<template>
    <div>
        <div class="row">
            <div class="card card-primary card-outline col-12">
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
                            <th>{{ local[lang+".members"]["name"] }}</th>
                            <th>{{ local[lang+".members"]["email"] }}</th>
                            <th>
                                <span class="badge badge-info">{{firms.total}}</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="(firm,index) in firms.data" :key="firm.id">
                            <td>
                                <img :src="firm.avatar+'?r='+Math.random()" class="rounded-circle mx-1" width="24px"/>
                                {{ firm.name }}
                            </td>
                            <td>{{firm.email}}</td>
                            <td>
                                <button
                                    type="button"
                                    class="btn btn-sm btn-info text-white"
                                    @click="editFirm(firm)"
                                >
                                    <i class="fa fa-edit"></i>
                                </button>
                                <button type="button" class="btn btn-sm btn-danger" @click="removeFirm(firm)">
                                    <i class="fa fa-trash"></i>
                                </button>

                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <hr/>
                    <div class="p-2">
                        <pagination :data="Object.assign({},firms)" @pagination-change-page="getResults"></pagination>
                    </div>
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
                            v-show="firm.id==null"
                        >{{ local[lang+".members"]["create-firm"] }}</h4>
                        <h4
                            class="modal-title w-100 font-weight-bold"
                            v-show="firm.id!=null"
                        >{{ local[lang+".members"]["edit-firm"] }}</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form @submit.prevent="addEditFirm">
                        <div class="modal-body mx-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
						<span class="input-group-text">
							<i class="fas fa-envelope"></i>
						</span>
                                </div>
                                <input
                                    type="text"
                                    v-model="firm.name"
                                    class="form-control"
                                    :placeholder="local[lang+'.members']['name']"
                                    required
                                />
                            </div>
                            <div v-if="errors && errors.name" class="text-danger">{{ errors.name[0] }}</div>

                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
						<span class="input-group-text">
							<i class="fas fa-user"></i>
						</span>
                                </div>
                                <input
                                    type="email"
                                    v-model="firm.email"
                                    class="form-control"
                                    :placeholder="local[lang+'.members']['email']"
                                    required
                                />
                            </div>
                            <div v-if="errors && errors.email" class="text-danger">{{ errors.email[0] }}</div>

                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
						<span class="input-group-text">
							<i class="fas fa-lock"></i>
						</span>
                                </div>
                                <input
                                    type="password"
                                    v-model="firm.password"
                                    class="form-control"
                                    :placeholder="local[lang+'.members']['password']"
                                    :required="firm.id==null"
                                />
                            </div>
                            <div v-if="errors && errors.password" class="text-danger">{{ errors.password[0] }}</div>
                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-cog fa-spin" v-show="loading"></i>
                                <i class="fas fa-cog" v-show="!loading"></i>
                                <span class="px-1">{{ local[lang+".members"]["save"] }}</span>
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
        name: "FirmComponent",
        props: ["auth", "lang", "acl"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                firms: [],
                local: CONFIG.LANG,
                index: null,
                UID: null,
                firm: {
                    id: null,
                    name: null,
                    email: null,
                    password: null
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
                        "firms?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.firms = res.data;
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
                        "search/firms?page=" +
                        page +
                        "&keywords=" +
                        this.keywords +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.firms = res.data;
                        this.loading = false;
                    });
            },
            addEditFirm(firm = null) {
                this.loading = true;
                if (this.firm.id) {
                    axios
                        .put(
                            CONFIG.API_URL +
                            "firms/" +
                            this.firm.id +
                            "?api_token=" +
                            this.auth.api_token,
                            this.firm
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
                            CONFIG.API_URL + "firms" + "?api_token=" + this.auth.api_token,
                            this.firm
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
            editFirm(firm) {
                this.firm.id = firm.id;
                this.firm.name = firm.name;
                this.firm.email = firm.email;
                $("#addFeed").modal("show");
            },
            removeFirm(firm) {
                var conf = confirm(this.local[this.lang + ".alerts"]["confirm-delete"]);
                if (conf) {
                    this.loading = false;
                    axios
                        .delete(
                            CONFIG.API_URL +
                            "firms/" +
                            firm.id +
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
                this.firm.name = this.firm.email = this.firm.password = null;
            }
        }
    };
</script>

<style scoped>
</style>
