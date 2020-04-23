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

firebase.initializeApp({
    apiKey: ' AIzaSyCTVK3-WwlNPFuvN8IZ2mPT5D02qSchMsI',
    projectId: 'urkeydeliveryapp'
});
const db = firebase.firestore();
const dbAuth=firebase.auth();
window.Vue = require('vue');
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
Vue.component('firms', require('./components/FirmComponent.vue').default);

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
    //API_URL: 'https://'+window.location.hostname+'/public/api/',
    //PATH: '/public',
    API_URL: 'http://'+window.location.hostname+'/urkey/public/api/',
    PATH: '/urkey/public',
    LANG: translations,
    DB:db,
    dbAuth:dbAuth,
    coolNumber:coolNumber

}

export default CONFIG;

const app = new Vue({
    el: '#app',
});
