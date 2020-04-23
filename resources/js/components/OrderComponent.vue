<template>

    <div >
        <div class="row">
            <div class="'card card-primary card-outline col-lg-12">
                <div class="card-header">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addFeed">
                        <i class="fas fa-plus"></i>
                    </button>
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
                        <tbody>
                        <tr v-for="(order, index) in orders" :key="orders.id" :class="(order.driver.name)?'table-warning':''">
                            <td>{{order.id}}</td>
                            <td>{{new Date(order.timestamp.seconds*1000) | moment("from", "now")}}</td>
                            <td><img :src="order.agent.avatarURL" class="rounded-circle" width="42px" alt=""> {{order.agent.name}}</td>
                            <td><img :src="order.firm.avatarURL" class="rounded-circle" width="42px" alt=""> {{order.firm.name}}</td>
                            <td ><img :src="order.driver.avatarURL" class="rounded-circle" width="42px" alt=""> {{order.driver.name}}</td>
                            <td></td>
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
        name: "orders",
        props: ["auth", "lang", "roles","acl"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                orders: [],
                total:0,
                local: CONFIG.LANG,

                keywords: null,
                errors: []
            };
        },
        created() {
            this.getResults();
        },
        watch: {

        },
        methods: {
            getResults() {
                this.loading = true;
                const query=CONFIG.DB.collection('orders');
                query.onSnapshot(snap=>{
                    this.total=snap.size;
                    snap.forEach(doc=>{
                        let item={};
                        item.id=doc.data().id;
                        item.timestamp=doc.data().timestamp;
                        item.agent=doc.data().agent;
                        item.firm=doc.data().firm;
                        item.driver={};
                        CONFIG.DB.collection('users').doc(doc.data().driverID).get()
                        .then(doc=>{
                            if (doc.exists) {
                                item.driver=doc.data();
                            }

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

        }
    };
</script>

<style scoped>

</style>
