<template>
    <div >
        <div class="row">
            <div :class="'card card-primary card-outline col-lg-'+roleSlide">
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
                            <th>{{local[lang+'.products']['title']}}</th>
                            <th>{{local[lang+'.products']['desc']}}</th>
                            <th>{{local[lang+'.products']['unit']}}</th>
                            <th>{{local[lang+'.products']['price']}}</th>
                            <th>{{local[lang+'.products']['actions']}}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="(product,index) in products.data" :key="product.id">
                            <td>
                                {{ product.title }}
                            </td>
                            <td>{{product.desc.slice(0,50)}}...</td>
                            <td>{{product.unit}}</td>
                            <td>{{product.price}}</td>

                            <td>
                                <button
                                    type="button"
                                    class="btn btn-sm btn-info text-white"
                                    @click="editProduct(product)"
                                >
                                    <i class="fa fa-edit"></i>
                                </button>
                                <button type="button" class="btn btn-sm btn-danger" @click="removeProduct(product)">
                                    <i class="fa fa-trash"></i>
                                </button>
                                <button
                                    type="button"
                                    class="btn btn-sm btn-warning"
                                    @click="expandRoles(product,index)"
                                    v-show="acl.give_permissions"
                                >
                                    <i class="fa fa-lock"></i>
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <hr/>
                    <div class="p-2">
                        <pagination :data="Object.assign({},products)" @pagination-change-page="getResults"></pagination>
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
                aria-hidden="true"
            >
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header text-center">
                            <h4
                                class="modal-title w-100 font-weight-bold"
                                v-show="product.id==null"
                            >{{local[lang+'.products']['create-product']}}</h4>
                            <h4
                                class="modal-title w-100 font-weight-bold"
                                v-show="product.id!=null"
                            >Edit an Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form @submit.prevent="addEditProduct">
                            <div class="modal-body mx-3">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <i class="fa fa-pen"></i>
                                        </div>
                                    </div>
                                    <input
                                        type="text"
                                        v-model="product.title"
                                        class="form-control"
                                        :placeholder="local[lang+'.products']['title']"
                                        required
                                    />
                                </div>
                                <div v-if="errors && errors.title" class="text-danger">{{ errors.name[0] }}</div>

                                <div class="input-group mt-3">
                                    <textarea
                                        v-model="product.desc"
                                        class="form-control"
                                        rows="3"
                                        :placeholder="local[lang+'.products']['desc']"
                                        required
                                    >
                                    </textarea>
                                </div>
                                <div v-if="errors && errors.desc" class="text-danger">{{ errors.email[0] }}</div>

                                <div class="input-group mt-3">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <i class="fa fa-question"></i>
                                        </div>
                                    </div>
                                    <input
                                        type="text"
                                        v-model="product.unit"
                                        class="form-control"
                                        :placeholder="local[lang+'.products']['unit']"
                                        :required="product.id==null"
                                    />
                                </div>
                                <div v-if="errors && errors.unit" class="text-danger">{{ errors.password[0] }}</div>

                                <div class="input-group mt-3">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <i class="fa fa-dollar-sign"></i>
                                        </div>
                                    </div>
                                    <input
                                        type="text"
                                        v-model="product.price"
                                        class="form-control"
                                        :placeholder="local[lang+'.products']['price']"
                                        :required="product.id==null"
                                    />
                                </div>

                                <div v-if="errors && errors.price" class="text-danger">{{ errors.password[0] }}</div>

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
        name: "ProductComponent.vue",
        props: ["auth", "lang", "roles","acl"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                roleSlide: 12,
                products: [],
                local: CONFIG.LANG,
                cRoles: [],
                index: null,
                UID: null,
                product: {
                    id: null,
                    title: null,
                    desc: null,
                    unit: null,
                    price:null,
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
                        "products?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.products = res.data;
                        this.loading = false;
                    });
            },
            search(page) {
                this.loading = true;
                if (typeof page === "undefined") {
                    page = 1;
                }
                axios
                    .get(
                        CONFIG.API_URL +
                        "search/products?page=" +
                        page +
                        "&keywords=" +
                        this.keywords +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.products = res.data;
                        this.loading = false;
                    });
            },
            addEditProduct(product = null) {
                this.loading = true;
                if (this.product.id) {
                    axios
                        .put(
                            CONFIG.API_URL +
                            "products/" +
                            this.product.id +
                            "?api_token=" +
                            this.auth.api_token,
                            this.product
                        )
                        .then(res => {
                            this.loading = false;
                            $("#addFeed").modal("hide");
                            toastr["success"](
                                this.local[this.lang + ".alerts"]["updated"],
                                this.local[this.lang + ".alerts"]["ok"]
                            );
                            this.getResults(1);
                            this.clearFields();
                        })
                        .catch(error => {
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
                } else {
                    axios
                        .post(
                            CONFIG.API_URL + "products" + "?api_token=" + this.auth.api_token,
                            this.product
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
                }
            },
            editProduct(product) {
                this.product.id = product.id;
                this.product.title = product.title;
                this.product.desc = product.desc;
                this.product.unit = product.unit;
                this.product.price = product.price;
                $("#addFeed").modal("show");
            },
            removeProduct(product) {
                var conf = confirm(this.local[this.lang + ".alerts"]["confirm-delete"]);
                if (conf) {
                    this.loading = false;
                    axios
                        .delete(
                            CONFIG.API_URL +
                            "products/" +
                            product.id +
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
                this.product.title = this.product.desc = this.product.unit = this.product.price = null;
            }
        }
    };
</script>

<style scoped>
</style>
