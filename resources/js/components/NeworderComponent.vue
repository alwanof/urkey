<template>
    <div>
        <div class="row">
            <div class="card card-primary card-outline col-12">
                <div class="card-header h3">
                    <button class="btn btn-success" data-target="#addFeed" data-toggle="modal" type="button">
                        <i class="fas fa-plus"></i>
                    </button>
                    <span class="badge badge-warning" v-show="packets.length>0">{{order.id}}</span>
                    <i class="fas fa-cog fa-spin px-2 text-primary" v-show="loading"></i>

                </div>
                <div v-show="packets.length>0">
                    <div class="card-body p-0 table-responsive" >
                        <table class="table table-striped table-hover table-head-fixed">
                            <thead>
                            <tr>
                                <th>{{ local[lang+".orders"]["name"] }}</th>
                                <th>{{ local[lang+".orders"]["phone"] }}</th>
                                <th>{{ local[lang+".orders"]["district"]}}</th>
                                <th>{{ local[lang+".orders"]["address"]}}</th>
                                <th>
                                    <span class="badge badge-info">{{packets.length}}</span>
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                                <tr  :key="packet.id" v-for="(packet,index) in packets">
                                    <td>{{ packet.name }}</td>
                                    <td>{{ packet.phone }}</td>
                                    <td>{{ packet.destination.district }}</td>
                                    <td>{{ packet.destination.address }}</td>
                                    <td>
                                        <button
                                            @click="editPacket(packet)"
                                            class="btn btn-sm btn-info text-white"
                                            type="button">
                                            <i class="fa fa-edit"></i>
                                        </button>
                                        <button @click="removePacket(packet)" class="btn btn-sm btn-danger" type="button">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>


                            </tbody>
                        </table>


                    </div>
                    <hr>
                    <button type="button" class="btn btn-lg btn-success float-right m-2" @click="makeOrder">
                        <i class="far fa-save"></i>
                        {{local[lang+".orders"]["save"]}}
                    </button>
                </div>

            </div>
        </div>
        <!-- The Modal -->
        <div
            aria-hidden="true"
            aria-labelledby="myModalLabel"
            class="modal fade"
            id="addFeed"
            role="dialog"
            tabindex="-1">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h4
                            class="modal-title w-100 font-weight-bold">
                            {{ local[lang+".orders"]["add-packet"] }}
                        </h4>

                        <button aria-label="Close" class="close" data-dismiss="modal" type="button">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form @submit.prevent="addPacket">
                        <div class="modal-body mx-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-user"></i>
                            </span>
                                </div>
                                <input
                                    :placeholder="local[lang+'.orders']['name']"
                                    class="form-control"
                                    required
                                    type="text"
                                    v-model="packet.name"
                                />
                            </div>
                            <div class="text-danger" v-if="errors && errors.name">{{ errors.name[0] }}</div>

                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-phone"></i>
                            </span>
                                </div>
                                <input
                                    :placeholder="local[lang+'.orders']['phone']"
                                    class="form-control"
                                    required
                                    type="text"
                                    v-model="packet.phone"
                                />
                            </div>
                            <div class="text-danger" v-if="errors && errors.phone">{{ errors.phone[0] }}</div>

                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-city"></i>
                            </span>
                                </div>
                                <select class="form-control" v-model="packet.destination.district" required>
                                    <option value="0" disabled selected>{{local[lang+'.orders']['district']}}</option>
                                    <option  v-for="dist in dists" :key="dist.district_name" :value="dist.district_name">{{dist.district_name}}</option>
                                </select>

                            </div>

                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="far fa-building"></i>
                            </span>
                                </div>
                                <input
                                    :placeholder="local[lang+'.orders']['address']"
                                    class="form-control"
                                    required
                                    type="text"
                                    v-model="packet.destination.address"
                                />
                            </div>


                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <button class="btn btn-success" type="submit">
                                <i class="fas fa-cog fa-spin" v-show="loading"></i>
                                <i class="fas fa-cog" v-show="!loading"></i>
                                <span class="px-1">{{ local[lang+".orders"]["save"] }}</span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>



    </div>
</template>

<script>
    import CONFIG from "../app";
    import istDist from '../../../public/assets/istDist.json';
    export default {
        name: "NeworderComponent",
        props: ["auth", "lang", "acl","agent","firm"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                local: CONFIG.LANG,
                dists:istDist,
                packet: {
                    destination:{
                        address:null,
                        city:'Istanbul',
                        country:'Turkey.',
                        district:0,

                    },
                    id:null,
                    name:null,
                    phone:null,
                    location:null,
                    status:{},
                },
                packets: [],
                order: {
                    id:null,
                    agent:{},
                    distance:'null',
                    firm:{},
                    driverID:'null',
                    status:{},
                    timestamp:null,
                },

                errors: []
            };
        },
        created() {
            this.initOrder();
        },

        methods: {
            async makeOrder(){
                this.loading = true;

                await CONFIG.DB.collection('orders')
                    .doc(this.order.id)
                    .set(this.order)
                    .then(() => {

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
                let batch=CONFIG.DB.batch();
                this.packets.forEach(doc=>{
                    let docref=CONFIG.DB.collection('orders').doc(this.order.id).collection('packets').doc(doc.id);
                    batch.set(docref,doc);
                });
                await batch.commit();


                this.initOrder();
                this.clearFields();
                this.loading = false;

                /*await CONFIG.DB.collection('orders').doc(this.oid).collection('packets').doc(this.order.id)
                    .set(this.packet)
                    .then(()=>{console.log('success-added-packet')})
                    .catch((error)=>{console.log(error)});*/

            },
            initOrder(){
                this.order.id=this.makeid(16);
                this.fresh=true;
                this.order.status={
                    timestamp:new Date(),
                    value:"0"
                };
                this.order.timestamp=new Date();
                this.order.agent={
                    avatarURL:this.agent.avatar,
                    id:this.agent.uid,
                    name:this.agent.name
                };
                this.order.firm={
                    avatarURL:this.firm.avatar,
                    id:this.firm.uid,
                    name:this.firm.name
                };
                this.packets=[];
            },
            async addPacket(){
                this.loading = true;
               this.packet.id=this.makeid(16);
               console.log('https://maps.googleapis.com/maps/api/geocode/json?address='+this.packet.destination.district+','+this.packet.destination.address+','+this.packet.destination.city+'&key=AIzaSyCV64F_eRBIVJOdYHKcrO5zUuMjW9QS-1A');
                await axios.get('https://maps.googleapis.com/maps/api/geocode/json?address='+this.packet.destination.district+','+this.packet.destination.address+','+this.packet.destination.city+'&key=AIzaSyCV64F_eRBIVJOdYHKcrO5zUuMjW9QS-1A')
                    .then(res=>{
                        this.packet.location=new CONFIG.FIRESTORE.GeoPoint(res.data.results[0].geometry.location.lat, res.data.results[0].geometry.location.lng);

                    });

               this.packet.status={
                   timestamp:new Date(),
                   value:"0"
               };
               let data=_.cloneDeep(this.packet);
               this.packets.push(data);
               this.clearFields();
                $("#addFeed").modal("hide");
                this.loading = false;


            },
            editPacket(packet){

            },
            removePacket(packet){

            },
            makeid(length) {
                var result           = '';
                var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                var charactersLength = characters.length;
                for ( var i = 0; i < length; i++ ) {
                    result += characters.charAt(Math.floor(Math.random() * charactersLength));
                }
                return result;
            },
            clearFields() {
                this.packet.name =this.packet.id= this.packet.phone= this.packet.destination.address = null;
                this.packet.destination.district=0;

            },


        }
    };
</script>

<style scoped>
</style>
