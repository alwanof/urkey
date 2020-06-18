<template>

    <div >
        <div class="row">
            <div class="'card card-danger card-outline col-lg-12">
                <div class="card-header h3">

                    <i class="fas fa-cog fa-spin px-2 text-primary" v-show="loading"></i>

                    <div class="card-tools">
                        <div class="input-group input-group-sm">
                            <input
                                type="text"
                                name="table_search"
                                v-model="keywords"
                                class="form-control float-right"
                                :placeholder=" local[lang+'.users']['search'] "
                            />

                            <div class="input-group-append">
                                <button type="submit" class="btn btn-default">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0 table-responsive">
                    <table class="table table-striped table-hover table-head-fixed">
                        <thead>
                        <tr>
                            <th>{{ local[lang+".orders"]["order_no"] }}</th>
                            <th>{{ local[lang+".orders"]["otimestamp"] }}</th>
                            <th> {{ local[lang+".orders"]["agent"] }}</th>
                            <th> {{ local[lang+".orders"]["firm"] }}</th>
                            <th> {{ local[lang+".orders"]["driver"] }}</th>
                            <th>
                                <span class="badge badge-info">{{total}}</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody v-for="(order, index) in orders" :key="order.id" >
                        <tr :class="'table-'+colorOrder(order.status.value)">
                            <td>{{order.id}}/{{order.status.value}}</td>
                            <td>{{new Date(order.timestamp.seconds*1000) | moment("from", "now")}}</td>
                            <td><img :src="order.agent.avatarURL" class="rounded-circle" width="42px" alt=""> {{order.agent.name}}</td>
                            <td><img :src="order.firm.avatarURL" class="rounded-circle" width="42px" alt=""> {{order.firm.name}}</td>
                            <td ><img :src="order.driver.avatarURL" class="rounded-circle" width="42px" alt=""> {{order.driver.name}} <span v-show="order.distance>0" class="badge badge-dark">~{{Math.round(order.distance/1000)}} km.</span></td>
                            <td>
                                <button v-show="acl.handover" type="button" @click="handover(order)" class="btn btn-dark" :disabled="order.status.value!='1'"><i class="fas fa-hands-helping"></i></button>
                            </td>
                        </tr>
                        <tr >
                            <td colspan="6">
                                <div :class="'my-1 p-1 table-'+colorPacket(packet.status.value)" v-for="(packet, index) in order.packets" :key="packet.id" >
                                    <div>
                                        <i class="far fa-user"></i> <span class="mx-1">{{packet.name}}</span>
                                        <i class="fas fa-phone-volume"></i> <span class="mx-1">{{packet.phone}}</span>
                                        <i class="far fa-clock"></i> <span class="mx-1">
                                        {{new Date(packet.status.timestamp.seconds*1000) | moment("from", "now")}}
                                        <span class="badge badge-secondary">{{local[lang+".orders"]["packet-status"][packet.status.value]}}</span>
                                        <span class="badge badge-warning">~{{Math.round(packet.distance/1000)}} km.</span>
                                    </span>
                                    </div>
                                    <div>
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span>{{packet.destination.address}} / {{packet.destination.district}}</span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        </tbody>

                    </table>
                    <hr/>
                    <div class="p-2">

                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import CONFIG from "../app";

    export default {
        name: "hotorders",
        props: ["auth", "lang", "roles","acl","agent","firm"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                orders: [],
                total:0,
                local: CONFIG.LANG,
                baseLocation:false,
                keywords: null,
                errors: [],
                colores:['red','blue']

            };
        },
        created() {
            this.getResults();


        },


        methods: {
            async getResults() {
                this.loading = true;
                const limit=await CONFIG.DB.collection('settings').doc('order_limit').get();

                let query;
                //console.log(this.acl.role[0].name);
                switch(this.acl.role[0].name){
                    case 'developer':
                        query=CONFIG.DB.collection('orders').where('status.value','in',['0','1','3','4']).limit(limit.data().value);
                        break;
                    case 'Firms':
                        query=CONFIG.DB.collection('orders').where('status.value','in',['0','1','3','4']).where('firm.id','==',this.firm.uid).limit(limit.data().value);
                        break;
                    case 'Agents':
                        query=CONFIG.DB.collection('orders').where('status.value','in',['0','1','3','4']).where('agent.id','==',this.agent.uid).limit(limit.data().value);
                        break;
                }

                query.onSnapshot(snap=>{
                    this.total=snap.size;
                    if(snap.size==0){
                        this.loading = false;
                    }
                    snap.forEach(doc=>{


                        let item={};
                        let packetItems=[];

                        CONFIG.DB.collection('orders').doc(doc.data().id).collection('packets')
                            .onSnapshot(packets=>{
                                packets.forEach(packet=>{
                                    let isExist = packetItems.find(o => o.id === packet.data().id);
                                    if(!isExist){
                                        packetItems.push(packet.data());
                                    }else{
                                        const index=packetItems.indexOf(isExist);
                                        packetItems.splice(index, 1);
                                        packetItems.push(packet.data());
                                    }

                                });

                            });
                        item.id=doc.data().id;
                        item.timestamp=doc.data().timestamp;
                        item.status=doc.data().status;
                        item.agent=doc.data().agent;
                        item.firm=doc.data().firm;
                        item.distance=doc.data().distance;
                        item.driver={};
                        item.packets=packetItems;
                        CONFIG.DB.collection('users').doc(doc.data().driverID).get()
                            .then(doc=>{
                                if (doc.exists) {
                                    item.driver=doc.data();

                                }

                            })
                            .catch((error) => {
                                this.loading = false;
                                toastr["error"](
                                    this.local[this.lang + ".alerts"]["error"],
                                    this.local[this.lang + ".alerts"]["err"]
                                );
                            });


                        let isExist = this.orders.find(o => o.id === doc.data().id);
                        if(!isExist){
                            this.orders.push(item);
                        }else{
                            const index=this.orders.indexOf(isExist);
                            this.orders.splice(index, 1);
                            this.orders.push(item);

                        }

                        this.loading = false;
                    });
                });


            },
            handover(order){
                this.loading = true;
                CONFIG.DB.collection('orders')
                    .doc(order.id)
                    .update({
                        'status.value':'3'
            })
            .then(() => {
                    console.log(order.id);
                    this.loading = false;
                    toastr["success"](
                        this.local[this.lang + ".alerts"]["added"],
                        this.local[this.lang + ".alerts"]["ok"]
                    );
                })
                    .catch((error) => {
                        this.loading = false;
                        toastr["error"](
                            this.local[this.lang + ".alerts"]["error"],
                            this.local[this.lang + ".alerts"]["err"]
                        );
                    });

            },
            colorPacket(status){
                let result='';
                switch (status) {
                    case "0":
                        result="warning";
                        break;
                    case "1":
                        result="success";
                        break;
                    case "2":
                        result="danger";
                        break;
                    default:
                        result="";
                        break;
                }
                return result;
            },
            colorOrder(status){
                let result='';
                switch (status) {
                    case "0":
                        result="danger";
                        break;
                    case "1":
                        result="info";
                        break;
                    case "2":
                        result="success";
                        break;
                    case "3":
                        result="primary";
                        break;
                    case "4":
                        result="warning";
                        break;
                    default:
                        result="";
                        break;
                }
                return result;
            }


        }
    };
</script>

<style scoped>

</style>
