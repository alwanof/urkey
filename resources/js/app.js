/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */
//git fetch --all
//git reset --hard origin/master

require('./bootstrap');

window.Vue = require('vue');

import translations from '../lang/vue-translations.json'
//php artisan lang:js resources/lang/vue-translations.json --json

Vue.component('pagination', require('laravel-vue-pagination'));
Vue.component('example-component', require('./components/ExampleComponent.vue').default);
Vue.component('user-component', require('./components/UserComponent.vue').default);
Vue.component('role-component', require('./components/RoleComponent.vue').default);
Vue.component('permission-component', require('./components/PermissionComponent.vue').default);
Vue.component('config-component', require('./components/ConfigComponent.vue').default);
Vue.component('settings-component', require('./components/SettingsComponent.vue').default);
Vue.component('product-component',require('./components/ProductComponent.vue').default);
Vue.component('order-component',require('./components/OrderComponent.vue').default);
Vue.component('order-pending-component',require('./components/PendingOrdersComponent.vue').default);
Vue.component('order-approved-component',require('./components/ApprovedOrdersComponent.vue').default);
Vue.component('order-completed-component',require('./components/CompletedOrdersComponent.vue').default);
Vue.component('bill-component',require('./components/BillComponent').default);
Vue.component('order-create-component',require('./components/CreateOrderComponent.vue').default);
Vue.component('order-edit-component',require('./components/EditOrderComponent.vue').default);
Vue.component('order-edit-pending-component',require('./components/EditPendingOrderComponent.vue').default);
Vue.component('order-edit-approved-component',require('./components/EditApprovedOrderComponent.vue').default);
Vue.component('order-edit-completed-component',require('./components/EditCompletedOrderComponent.vue').default);
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
    coolNumber:coolNumber

}

export default CONFIG;

const app = new Vue({
    el: '#app',
});
