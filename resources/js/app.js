/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */
//git fetch --all
//git reset --hard origin/master

require('./bootstrap');
const firebase = require("firebase");
require("firebase/firestore");
import * as VueGoogleMaps from 'vue2-google-maps';

firebase.initializeApp({
    apiKey: ' AIzaSyCTVK3-WwlNPFuvN8IZ2mPT5D02qSchMsI',
    projectId: 'urkeydeliveryapp'
});
const db = firebase.firestore();
const firestore = firebase.firestore;
const dbAuth=firebase.auth();
window.Vue = require('vue');
Vue.use(VueGoogleMaps,{
    load:{
        key:'AIzaSyCV64F_eRBIVJOdYHKcrO5zUuMjW9QS-1A',
        libraries: 'places,directions'
    },
});
Vue.use(require('vue-moment'));
import translations from '../lang/vue-translations.json'
//php artisan lang:js resources/lang/vue-translations.json --json

Vue.component('pagination', require('laravel-vue-pagination'));

Vue.component('user-component', require('./components/UserComponent.vue').default);
Vue.component('role-component', require('./components/RoleComponent.vue').default);
Vue.component('permission-component', require('./components/PermissionComponent.vue').default);
Vue.component('config-component', require('./components/ConfigComponent.vue').default);
Vue.component('settings-component', require('./components/SettingsComponent.vue').default);
Vue.component('orders', require('./components/OrderComponent.vue').default);
Vue.component('hotorders', require('./components/HotorderComponent.vue').default);
Vue.component('firms', require('./components/FirmComponent.vue').default);
Vue.component('agents', require('./components/AgentComponent.vue').default);
Vue.component('drivers', require('./components/DriverComponent.vue').default);
Vue.component('neworder', require('./components/NeworderComponent.vue').default);
Vue.component('trackingmap', require('./components/TrackingmapComponent.vue').default);

function coolNumber(num){
    if(num <1000){
        return $num;
    }

    if(num <1000000){
        return (num/1000)+'K';
    }
    if($num >=1000000){
        return (num/1000000)+'M';
    }
}
const CONFIG = {
    API_URL: 'https://'+window.location.hostname+'/godelivery/public/api/',
    PATH: '/godelivery/public',
    AppURL:'http://'+window.location.hostname+'/godelivery/public/',
    //API_URL: 'http://'+window.location.hostname+'/urkey/public/api/',
    //PATH: '/urkey/public',
    //AppURL:'http://'+window.location.hostname+'/urkey/public/',
    LANG: translations,
    DB:db,
    FIRESTORE:firestore,
    dbAuth:dbAuth,
    coolNumber:coolNumber

}

export default CONFIG;

const app = new Vue({
    el: '#app',
});
