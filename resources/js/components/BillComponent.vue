<template>
    <div>
        <div class="row">
            <div class="card card-primary card-outline col-lg-12">
                <div class="card-header">
                    <button type="button" v-show="acl.admin_add_transaction" class="btn btn-success" data-toggle="modal" data-target="#addFeed">
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
                            <th>{{local[lang+'.bills']['title']}}</th>
                            <th>{{local[lang+'.bills']['amount']}}</th>
                            <th>{{local[lang+'.bills']['order']}}</th>
                            <th>{{local[lang+'.bills']['agent']}}</th>
                            <th>{{local[lang+'.bills']['date']}}</th>
                            <th>{{local[lang+'.bills']['actions']}}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="(bill,index) in bills.data" :key="bill.id">
                            <td>
                                {{ bill.title }}
                            </td>
                            <td :class="(bill.amount<0)?'text-danger':'text-dark'">{{bill.amount}}.00$</td>
                            <td>{{bill.order.title}}</td>
                            <td>{{bill.user.name}}</td>
                            <td>{{bill.created_at}}</td>
                            <td>
                                <button v-show="acl.admin_delete_transaction" type="button" class="btn btn-sm btn-danger" @click="removeBill(bill)">
                                    <i class="fa fa-trash"></i>
                                </button>

                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <hr/>
                    <div class="p-2">
                        <pagination :data="Object.assign({},bills)" @pagination-change-page="getResults"></pagination>
                    </div>
                </div>
            </div>
            <!-- The Modal -->
            <div
                class="modal fade"
                id="addFeed"
                tabindex="-1"
                role="dialog"
                aria-labelledby="myModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header text-center">
                            <h4 class="modal-title w-100 font-weight-bold">
                                {{local[lang+'.bills']['new_transaction']}}
                            </h4>

                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form @submit.prevent="addEditBill">
                            <div class="modal-body mx-3">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                          <i class="far fa-file-alt"></i>
                                        </span>
                                    </div>
                                    <input
                                        type="text"
                                        v-model="bill.title"
                                        class="form-control"
                                        :placeholder="local[lang+'.bills']['title']"
                                        required
                                    />
                                </div>
                                <div v-if="errors && errors.title" class="text-danger">{{ errors.title[0] }}</div>
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                          <i class="fas fa-pen"></i>
                                        </span>
                                    </div>
                                    <input
                                        type="number"
                                        v-model="bill.amount"
                                        class="form-control"
                                        :placeholder="local[lang+'.bills']['amount']"
                                        required
                                    />
                                </div>
                                <div v-if="errors && errors.amount" class="text-danger">{{ errors.amount[0] }}</div>
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                          <i class="far fa-file-alt"></i>
                                        </span>
                                    </div>
                                    <select  class="form-control" v-model="bill.order_id"  required >
                                        <option value="0"   disabled>{{local[lang+'.bills']['order']}}</option>
                                        <option :value="oItem.id" v-for="oItem in orders" :key="oItem.id">
                                            {{oItem.title}} -{{oItem.created_at}}
                                        </option>
                                    </select>

                                </div>
                                <div v-if="errors && errors.order_id" class="text-danger">{{ errors.order_id[0] }}</div>
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                          <i class="far fa-file-alt"></i>
                                        </span>
                                    </div>
                                    <select  class="form-control" v-model="bill.user_id" required >
                                        <option value="0"  disabled>{{local[lang+'.bills']['agent']}}</option>
                                        <option :value="oItem.id" v-for="oItem in users" :key="oItem.id">
                                            {{oItem.name}}
                                        </option>
                                    </select>

                                </div>
                                <div v-if="errors && errors.user_id" class="text-danger">{{ errors.user_id[0] }}</div>
                            </div>
                            <div class="modal-footer d-flex justify-content-center">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-cog fa-spin" v-show="loading"></i>
                                    <i class="fas fa-cog" v-show="!loading"></i>
                                    <span class="px-1">{{ local[lang+".users"]["save"] }}</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
        <!-- The Modal -->

    </div>
</template>

<script>
    import CONFIG from "../app";

    export default {
        name: "BillComponent.vue",
        props: ["auth", "lang","acl","orders","users"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                bills: [],
                local: CONFIG.LANG,
                index: null,
                UID: null,
                bill: {
                    id: null,
                    title: null,
                    amount: null,
                    order_id: 0,
                    user_id:0,
                },
                keywords: null,
                errors: []
            };
        },
        created() {
            this.getResults();
        },
        watch: {
            keywords(after, before) {
                if (this.keywords.length > 2 || this.keywords.length === 0) {
                    this.search();
                }
            }
        },
        methods: {
            getResults(page = 1) {
                this.loading = true;
                if (typeof page === "undefined") {
                    page = 1;
                }
                axios
                    .get(
                        CONFIG.API_URL +
                        "bills?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.bills = res.data;
                        this.loading = false;
                    });
            },
            search(page=1) {
                this.loading = true;
                if (typeof page === "undefined") {
                    page = 1;
                }
                axios
                    .get(
                        CONFIG.API_URL +
                        "search/bills?page=" +
                        page +
                        "&keywords=" +
                        this.keywords +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.bills = res.data;
                        this.loading = false;
                    });
            },
            addEditBill() {
                this.loading = true;
                axios
                    .post(
                        CONFIG.API_URL + "bills" + "?api_token=" + this.auth.api_token,
                        this.bill
                    )
                    .then(res => {
                        this.loading = false;
                        $("#addFeed").modal("hide");
                        toastr["success"](
                            this.local[this.lang + ".alerts"]["added"],
                            this.local[this.lang + ".alerts"]["ok"]
                        );
                        this.getResults(1);
                        this.clearFields();
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
                            this.clearFields();
                        }
                    });

            },
            editBill(bill) {
                this.bill.id = product.id;
                this.bill.title = bill.title;
                this.bill.amount = bill.amount;
                this.bill.order_id = bill.order_id;
                this.bill.user_id = this.auth.id;
                $("#addFeed").modal("show");
            },
            removeBill(bill) {
                var conf = confirm(this.local[this.lang + ".alerts"]["confirm-delete"]);
                if (conf) {
                    this.loading = false;
                    axios
                        .delete(
                            CONFIG.API_URL +
                            "bills/" +
                            bill.id +
                            "?api_token=" +
                            this.auth.api_token
                        )
                        .then(res => {
                            this.loading = false;
                            toastr["success"](
                                this.local[this.lang + ".alerts"]["removed"],
                                this.local[this.lang + ".alerts"]["ok"]
                            );
                            this.getResults(1);
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
            clearFields() {
                this.bill.title = this.bill.amount = this.bill.order_id = this.bill.user_id = null;
            }
        }
    };
</script>

<style scoped>
</style>
