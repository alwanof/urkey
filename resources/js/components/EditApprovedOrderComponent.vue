<template>
    <div >
        <div class="card">
            <div class="card-header">
                {{local[lang+'.orders']['approved_order_edit_heading']}}
                <i class="fas fa-cog fa-spin px-2 text-primary" v-show="loading"></i>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                {{local[lang+'.orders']['approved_order_edit_order_details']}}
                            </div>
                            <div class="card-body">
                                <form :action='path+"/admin/order/approved/update"' method="post">
                                    <input type="hidden" name="_token" :value="this.csrf_code">
                                    <input type="hidden" class="form-control" name="order_id" :value="this.order_id">
                                    <div class="form-group">
                                        <label for="order_title">{{local[lang+'.orders']['order_title']}}:</label>
                                        <div class="input-group mb-2">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <i class="fa fa-pen"></i>
                                                </div>
                                            </div>
                                            <input type="text" :placeholder="local[lang+'.orders']['order_title']" class="form-control" id="order_title" name="order_title" v-model="order.title" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="order_description">{{local[lang+'.orders']['order_description']}}:</label>
                                        <textarea class="form-control" :placeholder="local[lang+'.orders']['order_description']" id="order_description" rows="3" name="order_description" v-model="order.desc" required></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="note">{{local[lang+'.orders']['order_admin_note']}}:</label>
                                        <textarea class="form-control" :placeholder="local[lang+'.orders']['order_admin_note']" id="note" rows="3" name="note" v-model="order.note"></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="status_note">{{local[lang+'.orders']['order_status_note']}}:</label>
                                        <div class="input-group mb-2">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <i class="fa fa-sticky-note"></i>
                                                </div>
                                            </div>
                                            <input type="text" :placeholder="local[lang+'.orders']['order_status_note']" class="form-control" id="status_note" name="status_note" v-html="order.status_note" v-model="order.status_note" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="discount">{{local[lang+'.orders']['order_discount']}}:</label>
                                        <div class="input-group mb-2">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <i class="fa fa-money-bill"></i>
                                                </div>
                                            </div>
                                            <input type="text" :placeholder="local[lang+'.orders']['order_discount']" class="form-control" id="discount" name="discount" v-model="order.discount">
                                        </div>
                                    </div>

                                    <button type="submit" name = "approved"  value="0" class="btn btn-success float-right ml-3"><i class="fa fa-save"></i> {{local[lang+'.orders']['approved_order_save_button']}}</button>

                                    <button type="submit" name = "submit"  value="1" class="btn btn-warning float-right text-white"><i class="fa fa-check"></i> {{local[lang+'.orders']['approved_order_submit_for_review']}}</button>

                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <form @submit.prevent="AddToBasket" class="form-inline">
                                    <div class="form-group mb-2">
                                        <label for="products">{{local[lang+'.orders']['approved_order_products']}}:</label>
                                        <select class="form-control ml-3" id="products" name="products" v-model="product" required>
                                            <option v-for="(product,index) in products" :key="product.id"  v-bind:value="{id:product.id,price:product.price}">{{product.title}}</option>
                                        </select>
                                    </div>
                                    <div class="form-group mx-sm-3 mb-2 ">
                                        <label for="product_amount">{{local[lang+'.orders']['approved_order_amount']}}:</label>
                                        <input type="text" :placeholder="local[lang+'.orders']['approved_order_amount']" class="form-control ml-3" id="product_amount" name="product_amount" v-model="item.amount" required>
                                    </div>
                                    <button type="submit" class="btn btn-success float-right mb-2"><i class="fas fa-plus"></i></button>
                                </form>
                                <br>
                                <table class="table table-bordered table-striped table-hover table-head-fixed">
                                    <thead>
                                    <tr class="text-center">
                                        <th>{{local[lang+'.orders']['approved_order_table_product_name']}}</th>
                                        <th>{{local[lang+'.orders']['approved_order_table_product_unit']}}</th>
                                        <th>{{local[lang+'.orders']['approved_order_table_product_price']}}</th>
                                        <th>{{local[lang+'.orders']['approved_order_table_amount']}}</th>
                                        <th>{{local[lang+'.orders']['approved_order_table_discount']}}</th>
                                        <th>{{local[lang+'.orders']['approved_order_table_sub_total']}}</th>
                                        <th>{{local[lang+'.orders']['approved_order_table_actions']}}</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr v-for="(item,index) in order_products" :key="item.id" class="text-center">
                                        <td>{{item.product.title}}</td>
                                        <td>{{item.product.unit}}</td>
                                        <td>{{item.price}}</td>
                                        <td>{{item.amount}}</td>
                                        <td>{{item.discount}}</td>
                                        <td>{{(item.subTotal)}}</td>
                                        <td>
                                            <button type="button" class="btn btn-block  btn-sm btn-danger" @click="removeItem(item.id)">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                            <button type="button" @click="editItem(item)" class="btn btn-block mt-2 btn-sm btn-primary">
                                                <i class="fa fa-edit"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="text-right text-bold h2">
                                            {{local[lang+'.orders']['pending_order_table_total']}}
                                        </td>
                                        <td colspan="3" class="h2" v-show="get_order_total">
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
        <div class="modal fade" id="editItem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edit Item :</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form @submit.prevent="updateAnItem">
                        <div class="modal-body">
                            <input type="hidden" name="_token" :value="this.csrf_code">
                            <input type="hidden" class="form-control" name="item_id" :value="this.item.id">
                            <div class="form-group">
                                <label for="item_desc">Item Description :</label>
                                <input type="text" placeholder="Item Description" class="form-control" id="item_desc" name="item_desc" v-model="item.desc">
                            </div>
                            <div class="form-group">
                                <label for="item_amount">Amount Of Item :</label>
                                <input type="text" placeholder="Item Amount" class="form-control" id="item_amount" name="item_amount" v-model="item.amount">
                            </div>
                            <div class="form-group">
                                <label for="item_price">Item Price :</label>
                                <input type="text" placeholder="Item Price" class="form-control" id="item_price" name="item_price" v-model="item.price">
                            </div>
                            <div class="form-group">
                                <label for="item_discount">Item Discount :</label>
                                <input type="text" placeholder="Item Discount" class="form-control" id="item_discount" name="item_discount" v-model="item.discount">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-cog fa-spin" v-show="loading"></i>
                                <i class="fas fa-cog" v-show="!loading"></i>
                                <span class="px-1">Save</span>
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

    export default {
        name: "EditApprovedOrderComponent.vue",
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
            this.get_order_info();
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

                    total=total+value.subTotal;
                });

                return total;
            },
            clear_second_form_field() {
                this.item.amount = this.product.id = this.product.price = null;
            },
            get_order_info(page = 1){
                this.loading = true;
                if (typeof page === "undefined") {
                    page = 1;
                }
                axios
                    .get(
                        CONFIG.API_URL +
                        "order/"+ this.order_id +"/informations?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.order = res.data;
                        this.loading = false;
                    });
            },
            editItem(item) {
                this.item.id = item.id;
                this.item.desc = item.desc;
                this.item.amount = item.amount;
                this.item.price = item.price;
                this.item.discount = item.discount;
                $('#editItem').modal('show');
            },
            updateAnItem(){
                axios
                    .put(
                        CONFIG.API_URL +
                        "item/update/" +
                        this.item.id +
                        "?api_token=" +
                        this.auth.api_token,
                        this.item
                    )
                    .then(res => {
                        this.loading = false;
                        $("#editItem").modal("hide");
                        toastr["success"](
                            this.local[this.lang + ".alerts"]["updated"],
                            this.local[this.lang + ".alerts"]["ok"]
                        );
                        this.getOrderProducts(1);
                        this.clear_update_item_form_field();
                    })
                    .catch(error => {
                        this.loading = false;
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors || {};
                        } else {
                            $("#editItem").modal("hide");
                            toastr["error"](
                                this.local[this.lang + ".alerts"]["error"],
                                this.local[this.lang + ".alerts"]["err"]
                            );
                            this.clear_update_item_form_field();
                        }
                    });
            },
            clear_update_item_form_field() {
                this.item.desc = this.item.amount = this.item.price = this.item.discount = null;
            },

        }
    };
</script>

<style scoped>

</style>
