<template>
    <div >
        <div class="row">
            <div :class="'card card-primary card-outline col-lg-'+roleSlide">
                <div class="card-header">
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
                            <th>{{local[lang+'.orders']['id']}}</th>
                            <th>{{local[lang+'.orders']['client']}}</th>
                            <th>{{local[lang+'.orders']['title']}}</th>
                            <th>{{local[lang+'.orders']['desc']}}</th>
                            <th>{{local[lang+'.orders']['total']}}</th>
                            <th>{{local[lang+'.orders']['discount']}}</th>
                            <th>{{local[lang+'.orders']['note']}}</th>
                            <th>{{local[lang+'.orders']['status_note']}}</th>
                            <th>{{local[lang+'.orders']['created_at']}}</th>
                            <th>{{local[lang+'.orders']['actions']}}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="(order,index) in orders.data" :key="order.id">
                            <td>{{ order.id }}</td>
                            <td>{{order.user.name}}</td>
                            <td>
                                <a :href="path+'/admin/order/details/'+order.id">{{ order.title }}</a>
                            </td>
                            <td><a :title="order.desc">{{order.desc.substr(0,25)}}</a></td>
                            <td>
                                <b>$({{order.summary}}.00)</b><sup v-show="order.summary<order.total"><del>{{order.total}}.00</del></sup>
                            </td>
                            <td>{{order.discount}}</td>
                            <td>{{order.note}}</td>
                            <td v-html="order.status_note"></td>
                            <td>{{order.created_at}}</td>
                            <td>
                                <a v-show="acl.admin_edit_approved_order" :href="path+'/admin/order/update/approved/'+order.id"
                                    type="button"
                                    class="btn btn-sm btn-info btn-block text-white"
                                >
                                    <i class="fa fa-edit"></i>
                                </a>
                                <button v-show="acl.admin_delete_approved_order" type="button" class="btn btn-sm btn-block btn-danger" @click="removeProduct(order)">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <hr/>
                    <div class="p-2">
                        <pagination :data="Object.assign({},orders)" @pagination-change-page="getResults"></pagination>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import CONFIG from "../app";

    export default {
        name: "ApprovedOrdersComponent.vue",
        props: ["auth", "lang", "roles","acl"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                roleSlide: 12,
                orders: [],
                local: CONFIG.LANG,
                cRoles: [],
                index: null,
                UID: null,
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
                        "orders/all/approved?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.orders = res.data;
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
                        "search/orders/approved?page=" +
                        page +
                        "&keywords=" +
                        this.keywords +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.orders = res.data;
                        this.loading = false;
                    });
            },
            removeProduct(order) {
                var conf = confirm(this.local[this.lang + ".alerts"]["confirm-delete"]);
                if (conf) {
                    this.loading = false;
                    axios
                        .delete(
                            CONFIG.API_URL +
                            "orders/" +
                            order.id +
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
        }
    };
</script>

<style scoped>

</style>
