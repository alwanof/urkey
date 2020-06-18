<template>
    <div>
        <div class="card">
            <div class="card-header">
                <i class="fas fa-cog fa-spin px-2 text-primary" v-show="loading"></i>
            </div>
            <div class="card-body">
                <GmapMap ref="map" :center="center" :zoom="10" :draggable="true" style="width: 100%;height:400px">
                    <GmapMarker :clickable="true" :name="marker.name" :icon="marker.icon" v-for="(marker,index) in markers" :key="index" :position="marker.position" @click="openInfo(index)">
                        <gmap-info-window
                            :position=marker.position
                            :opened=marker.open >
                            {{marker.name}}
                        </gmap-info-window>
                    </GmapMarker>

                </GmapMap>

            </div>
        </div>
    </div>
</template>

<script>
    import CONFIG from "../app";

    export default {
        name: "Trackingmap",
        props: ["acl","auth", "lang","role","firm"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                local: CONFIG.LANG,
                center:{
                    lat:41.1374382,
                    lng:28.7547977
                },
                points:[],
                path4:null,
                drivers:[],
                markers: [],
            };
        },
        created() {

            this.loading = true;
            let drivers;
            switch(this.acl.role[0].name){
                case 'developer':
                    drivers=CONFIG.DB.collection('users').where('groupID','==','4');
                    break;
                case 'Firms':
                    drivers=CONFIG.DB.collection('users').where('firmID','==',this.firm.uid).where('groupID','==','4')
                    break;
                case 'Agents':
                    drivers=CONFIG.DB.collection('users').where('firmID','==',this.firm.uid).where('groupID','==','4')
                    break;

            }
            drivers.onSnapshot(snap=>{

                   snap.forEach(doc=>{

                       let item={
                           id:doc.data().id,
                           lat:doc.data().userPosition.latitude,
                           lng:doc.data().userPosition.longitude,
                           name:doc.data().name,
                           isAvailable:doc.data().isAvailable,
                           open:false
                       }
                       let  marker={
                           lat:item.lat,
                           lng:item.lng
                       }

                       let isExist = this.drivers.find(o => o.id === doc.data().id);
                       if(!isExist){
                           this.drivers.push(item);

                           this.markers.push({
                               id:item.id,
                               name:item.name,
                               position: marker,
                               open:item.open,
                               icon:(item.isAvailable=='0')?CONFIG.AppURL+'assets/dist/img/car-deactive.png':CONFIG.AppURL+'assets/dist/img/car-active.png'
                           });
                       }else{
                           const index=this.drivers.indexOf(isExist);
                           this.drivers.splice(index, 1);
                           this.markers.splice(index, 1);
                           this.drivers.push(item);

                           this.markers.push({
                               id:item.id,
                               name:item.name,
                               position: marker,
                               open:item.open,
                               icon:(item.isAvailable=='0')?CONFIG.AppURL+'assets/dist/img/car-deactive.png':CONFIG.AppURL+'assets/dist/img/car-active.png'
                           });
                       }
                       this.loading = false;
                   });
                });

        },

        methods: {
            async openInfo(index){

                this.center=this.markers[index].position;
                this.markers[index].open=!this.markers[index].open;

                this.loading = true;

                let orderID;
                await CONFIG.DB.collection('orders')
                    .where('status.value','==','4')
                    .where('driverID','==',this.markers[index].id)
                    .get()
                .then(snap=>{
                    snap.forEach(doc=>{
                        orderID=doc.data().id;
                    });


                })
                .catch(error=>{
                    console.log(error);
                    this.loading = false;
                });

                if(!orderID){
                    this.loading = false;
                    return false;
                }
                if(this.path4==orderID){
                    this.loading = false;
                    return false;
                }

                this.path4=orderID;

                await CONFIG.DB.collection('orders').doc(orderID).collection('packets')
                    .get()
                    .then(snap=>{
                        snap.forEach(doc=>{
                            this.points.push({
                                location:new google.maps.LatLng(doc.data().location.latitude,doc.data().location.longitude),
                                stopover: true
                            });
                        });

                    });
                this.directionsService = new google.maps.DirectionsService();
                this.directionsDisplay = new google.maps.DirectionsRenderer();
                this.directionsDisplay.setMap(this.$refs.map.$mapObject);
                var vm = this;
                let lastPoint=this.points.pop();
                vm.directionsService.route({
                    origin: this.markers[index].position, // Can be coord or also a search query
                    destination: lastPoint.location,
                    waypoints: this.points,
                    travelMode: 'DRIVING'
                }, function (response, status) {
                    if (status === 'OK') {
                        vm.directionsDisplay.setDirections(response); // draws the polygon to the map
                    } else {
                        console.log('Directions request failed due to ' + status);
                    }
                })



            },


        }
    };
</script>

<style scoped>
</style>
