<template>
    <div>
        <div class="card">
            <div class="card-header">
                {{local[lang+'.orders']['create_order']}}
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                {{local[lang+'.orders']['order_details']}}
                            </div>
                            <div class="card-body">
                                <form :action='path+"/admin/order/create"' method="post">
                                    <input type="hidden" name="_token" :value="this.csrf_code">
                                    <input type="hidden" class="form-control" name="order_id" :value="this.order_id">
                                    <div class="form-group">
                                        <label for="order_title">{{local[lang+'.orders']['order_title']}}</label>
                                        <div class="input-group mb-2">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text"><i class="fa fa-pen"></i></div>
                                            </div>
                                            <input type="text" :placeholder="local[lang+'.orders']['order_title']" class="form-control" id="order_title" name="order_title" v-model="order.title" required>
                                        </div>

                                    </div>

                                    <div class="form-group">
                                        <label for="order_description">{{local[lang+'.orders']['order_description']}}</label>
                                        <textarea class="form-control" :placeholder="local[lang+'.orders']['order_description']" id="order_description" rows="3" name="order_description" v-model="order.desc" required></textarea>
                                    </div>

                                    <button type="submit" name = "draft"  value="0" class="btn btn-success float-right ml-3">{{local[lang+'.orders']['draft_order_save_button']}}</button>
                                    <button type="submit" name = "submit"  value="1" class="btn btn-danger float-right ">{{local[lang+'.orders']['draft_order_submit_for_review']}}</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <form @submit.prevent="AddToBasket" class="form-inline">
                                    <div class="form-group mb-2">
                                        <label for="products">{{local[lang+'.orders']['draft_order_products']}}:</label>
                                        <select class="form-control ml-3" id="products" name="products" v-model="product" required>
                                            <option v-for="(product,index) in products" :key="product.id"  v-bind:value="{id:product.id,price:product.price}">{{product.title}}</option>
                                        </select>
                                    </div>
                                    <div class="form-group mx-sm-3 mb-2 ">
                                        <label for="product_amount">{{local[lang+'.orders']['draft_order_amount']}}:</label>
                                        <input type="text" :placeholder="local[lang+'.orders']['draft_order_amount']" class="form-control ml-3" id="product_amount" name="product_amount" v-model="item.amount" required>
                                    </div>
                                    <button type="submit" class="btn btn-success float-right mb-2"><i class="fas fa-plus"></i></button>
                                </form>
                                <br>
                                <table class="table table-bordered table-striped table-hover table-head-fixed">
                                    <thead>
                                        <tr class="text-center">
                                            <th>{{local[lang+'.orders']['draft_order_table_product_name']}}</th>
                                            <th>{{local[lang+'.orders']['draft_order_table_product_unit']}}</th>
                                            <th>{{local[lang+'.orders']['draft_order_table_product_price']}}</th>
                                            <th>{{local[lang+'.orders']['draft_order_table_amount']}}</th>
                                            <th>{{local[lang+'.orders']['draft_order_table_sub_total']}}</th>
                                            <th>{{local[lang+'.orders']['draft_order_table_actions']}}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(item,index) in order_products" :key="item.id" class="text-center">
                                            <td>{{item.product.title}}</td>
                                            <td>{{item.product.unit}}</td>
                                            <td>{{item.price}}</td>
                                            <td>{{item.amount}}</td>
                                            <td>{{(item.price * item.amount)}}</td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-danger" @click="removeItem(item.id)">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="text-right text-bold h2">
                                                {{local[lang+'.orders']['draft_order_table_total']}}
                                            </td>
                                            <td colspan="2" class="h2" v-show="get_order_total">
                                                <b>$({{order_total}}.00)</b>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="p-2">
                                    <pagination :data="Object.assign({},order_products)" @pagination-change-page="getOrderProducts"></pagination>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import CONFIG from "../app";

    export default {
        name: "CreateOrderComponent.vue",
        props: ["csrf_code","order_id","auth", "lang", "roles","acl"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                orders: [],
                order_products:[],
                products:[],
                local: CONFIG.LANG,
                index: null,
                order: {
                    id: null,
                    user_id: null,
                    title: null,
                    desc: null,
                    note:null,
                    discount:null,
                    status:null,
                    status_note:null,
                    created_at:null,
                    updated_at:null,
                },
                item : {
                    id:null,
                    product_id:null,
                    desc:null,
                    amount:null,
                    price:null,
                    discount:null,
                    order_id:null,
                },
                product:{
                    id: null,
                    title: null,
                    desc: null,
                    unit: null,
                    price:null,
                },
                order_total:0,
                errors: []
            };
        },
        created() {
            this.getOrderProducts();
            this.getAllProducts();
            this.get_order_total();
        },
        methods: {
            getOrderProducts(page = 1) {
                this.loading = true;
                if (typeof page === "undefined") {
                    page = 1;
                }
                axios
                    .get(
                        CONFIG.API_URL +
                        "order/" + this.order_id +"/products?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.order_products = res.data;
                        this.order_total = this.get_order_total();
                        this.loading = false;
                    });
            },
            removeItem(id) {
                var conf = confirm(this.local[this.lang + ".alerts"]["confirm-delete"]);
                if (conf) {
                    this.loading = false;
                    axios
                        .delete(
                            CONFIG.API_URL +
                            "order/item/" +
                            id +
                            "?api_token=" +
                            this.auth.api_token
                        )
                        .then(res => {
                            this.loading = false;
                            toastr["success"](
                                this.local[this.lang + ".alerts"]["removed"],
                                this.local[this.lang + ".alerts"]["ok"]
                            );
                            this.getOrderProducts(1);
                        })
                        .catch(error => {
                            this.loading = false;
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors || {};
                            } else {
                                toastr["error"](
                                    this.local[this.lang + ".alerts"]["error"],
                                    this.local[this.lang + ".alerts"]["err"]
                                );
                            }
                        });
                }

            },
            getAllProducts(page = 1) {
                this.loading = true;
                if (typeof page === "undefined") {
                    page = 1;
                }
                axios
                    .get(
                        CONFIG.API_URL +
                        "products/all?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.products = res.data;
                        this.loading = false;
                    });
            },
            AddToBasket(){
                this.loading = true;
                this.item.product_id = this.product.id;
                this.item.desc = 'sss';
                this.item.price = this.product.price;
                this.item.discount = 0;
                this.item.order_id = this.order_id;

                axios
                    .post(
                        CONFIG.API_URL + "item/new" + "?api_token=" + this.auth.api_token,
                        this.item
                    )
                    .then(res => {
                        this.loading = false;
                        $("#addFeed").modal("hide");
                        toastr["success"](
                            this.local[this.lang + ".alerts"]["added"],
                            this.local[this.lang + ".alerts"]["ok"]
                        );
                        this.getOrderProducts(1);
                        this.clear_second_form_field();
                    })
                    .catch(error => {
                        console.log(error);
                        this.loading = false;
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors || {};
                        } else {
                            $("#addFeed").modal("hide");
                            toastr["error"](
                                this.local[this.lang + ".alerts"]["error"],
                                this.local[this.lang + ".alerts"]["err"]
                            );
                        }
                    });
            },
            saveAsDraft(){
                this.loading = true;
                this.item.product_id = this.product.id;
                this.item.desc = 'sss';
                this.item.price = this.product.price;
                this.item.discount = 0;
                this.item.order_id = this.order_id;

                axios
                    .post(
                        CONFIG.API_URL + "item/new" + "?api_token=" + this.auth.api_token,
                        this.item
                    )
                    .then(res => {
                        this.loading = false;
                        $("#addFeed").modal("hide");
                        toastr["success"](
                            this.local[this.lang + ".alerts"]["added"],
                            this.local[this.lang + ".alerts"]["ok"]
                        );
                        this.getOrderProducts(1);
                        this.clear_second_form_field();
                    })
                    .catch(error => {
                        console.log(error);
                        this.loading = false;
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors || {};
                        } else {
                            $("#addFeed").modal("hide");
                            toastr["error"](
                                this.local[this.lang + ".alerts"]["error"],
                                this.local[this.lang + ".alerts"]["err"]
                            );
                        }
                    });
            },
            get_order_total(){

                let total=0;

                this.order_products.forEach((value) => {

                   total=total+(value.price*value.amount);
                });

                return total;
            },
            clear_second_form_field() {
                this.item.amount = this.product.id = this.product.price = null;
            }
        }
    };
</script>

<style scoped>

</style>
