<template>
    <div>
        <div class="row">
            <div class="card card-primary card-outline col-12">
                <div class="card-header">
                    <button class="btn btn-success" data-target="#addFeed" data-toggle="modal" type="button">
                        <i class="fas fa-plus"></i>
                    </button>
                    <i class="fas fa-cog fa-spin px-2 text-primary" v-show="loading"></i>

                    <div class="card-tools">
                        <div class="input-group input-group-sm">
                            <input
                                :placeholder=" local[lang+'.users']['search'] "
                                class="form-control float-right"
                                name="table_search"
                                type="text"
                                v-model="keywords"
                            />

                            <div class="input-group-append">
                                <button class="btn btn-default" type="submit">
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
                            <th>{{ local[lang+".members"]["phone"] }}</th>
                            <th>{{ local[lang+".members"]["date"] }}</th>
                            <th>{{ local[lang+".members"]["firm-name"] }}</th>
                            <th>
                                <span class="badge badge-info">{{drivers.total}}</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr :class="'table-'+makeColor(driver.status)" :key="driver.id"
                            v-for="(driver,index) in drivers.data">
                            <td>
                                <img :src="driver.avatar+'?r='+Math.random()" class="rounded-circle mx-1" width="24px"/>
                                {{ driver.name }}
                            </td>
                            <td>{{driver.email}}</td>
                            <td>{{driver.phone}}</td>
                            <td>{{driver.created_at | moment("from", "now")}}</td>
                            <td>
                                <img :src="driver.refID.avatar+'?r='+Math.random()" class="rounded-circle mx-1" width="24px"/>
                                {{driver.refID.name}}
                            </td>
                            <td>
                                <span v-show="acl.drivers_edit_trash">
                                    <button
                                        @click="editdriver(driver)"
                                        class="btn btn-sm btn-info text-white"
                                        type="button" v-show="driver.status==0">
                                    <i class="fa fa-edit"></i>
                                    </button>
                                    <button @click="removeDriver(driver)" class="btn btn-sm btn-danger" type="button"
                                            v-show="driver.status==0">
                                        <i class="fa fa-trash"></i>
                                    </button>

                                </span>

                                <span v-show="acl.drivers_activate">
                                    <button @click="activate(driver,index)" class="btn btn-sm btn-success"
                                            title="Create a mobile app account" type="button"
                                            v-show="driver.status==0">
                                        <i class="fas fa-mobile-alt"></i>
                                    </button>
                                </span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <hr/>
                    <div class="p-2">
                        <pagination :data="Object.assign({},drivers)" @pagination-change-page="getResults"></pagination>
                    </div>
                </div>
            </div>
        </div>
        <!-- The Modal -->
        <div
            aria-hidden="true"
            aria-labelledby="myModalLabel"
            class="modal fade"
            id="addFeed"
            role="dialog"
            tabindex="-1"
        >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h4
                            class="modal-title w-100 font-weight-bold"
                            v-show="driver.id==null"
                        >{{ local[lang+".members"]["create-new"] }}</h4>
                        <h4
                            class="modal-title w-100 font-weight-bold"
                            v-show="driver.id!=null"
                        >{{ local[lang+".members"]["edit-item"] }}</h4>
                        <button aria-label="Close" class="close" data-dismiss="modal" type="button">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form @submit.prevent="addEditdriver">
                        <div class="modal-body mx-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </span>
                                </div>
                                <input
                                    :placeholder="local[lang+'.members']['name']"
                                    class="form-control"
                                    required
                                    type="text"
                                    v-model="driver.name"
                                />
                            </div>
                            <div class="text-danger" v-if="errors && errors.name">{{ errors.name[0] }}</div>

                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-envelope"></i>
                                    </span>
                                </div>
                                <input
                                    :placeholder="local[lang+'.members']['email']"
                                    class="form-control"
                                    required
                                    type="email"
                                    v-model="driver.email"
                                />
                            </div>
                            <div class="text-danger" v-if="errors && errors.email">{{ errors.email[0] }}</div>

                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-phone"></i>
                                    </span>
                                </div>
                                <input
                                    :placeholder="local[lang+'.members']['phone']"
                                    class="form-control"
                                    required
                                    type="text"
                                    v-model="driver.phone"
                                />
                            </div>
                            <div class="text-danger" v-if="errors && errors.phone">{{ errors.phone[0] }}</div>

                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-lock"></i>
                                    </span>
                                </div>
                                <input
                                    :placeholder="local[lang+'.members']['password']"
                                    :required="driver.id==null"
                                    class="form-control"
                                    type="password"
                                    v-model="driver.password"
                                />
                            </div>
                            <div class="text-danger" v-if="errors && errors.password">{{ errors.password[0] }}</div>
                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-building"></i>
                                    </span>
                                </div>
                                <select class="form-control" v-model="driver.ref">
                                    <option value="0" disabled selected>{{local[lang+'.members']['firm-name']}}</option>
                                    <option  v-for="firm in firms" :key="firm.id" :value="firm.uid">{{firm.name}}</option>
                                </select>
                            </div>
                            <div class="text-danger" v-if="errors && errors.email">{{ errors.email[0] }}</div>
                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <button class="btn btn-success" type="submit">
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
        name: "DriverComponent",
        props: ["auth", "lang", "acl", "firms"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                drivers: [],
                local: CONFIG.LANG,
                index: null,
                driver: {
                    id: null,
                    name: null,
                    email: null,
                    password: null,
                    phone: null,
                    ref:0
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
                        "drivers?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.drivers = res.data;
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
                        "search/drivers?page=" +
                        page +
                        "&keywords=" +
                        this.keywords +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.drivers = res.data;
                        this.loading = false;
                    });
            },
            addEditdriver(driver = null) {
                this.loading = true;
                if (this.driver.id) {
                    axios
                        .put(
                            CONFIG.API_URL +
                            "drivers/" +
                            this.driver.id +
                            "?api_token=" +
                            this.auth.api_token,
                            this.driver
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
                            CONFIG.API_URL + "drivers" + "?api_token=" + this.auth.api_token,
                            this.driver
                        )
                        .then(res => {

                            $("#addFeed").modal("hide");
                            toastr["success"](
                                this.local[this.lang + ".alerts"]["added"],
                                this.local[this.lang + ".alerts"]["ok"]
                            );
                            this.getResults(1);
                            this.clearFields();
                            this.loading = false;
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
            editdriver(driver) {
                this.driver.id = driver.id;
                this.driver.name = driver.name;
                this.driver.email = driver.email;
                this.driver.phone = driver.phone;
                this.driver.ref = driver.ref;
                $("#addFeed").modal("show");
            },
            removeDriver(driver) {
                var conf = confirm(this.local[this.lang + ".alerts"]["confirm-delete"]);
                if (conf) {
                    this.loading = false;
                    axios
                        .delete(
                            CONFIG.API_URL +
                            "drivers/" +
                            driver.id +
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

            activate(driver, index) {
                axios.post(
                    CONFIG.API_URL + "activate/driver" + "?api_token=" + this.auth.api_token,
                    driver
                ).then(res => {
                    this.drivers.data[index].status = 2;
                });
                this.loading = true;
                var today = new Date();
                CONFIG.dbAuth.createUserWithEmailAndPassword(driver.email,driver.password)
                    .then(doc=>{

                        CONFIG.DB.collection('users')
                            .doc(doc.user.uid)
                            .set({
                                avatarURL: driver.avatar,
                                email: driver.email,
                                firmID:driver.ref,
                                driverID: null,
                                groupID: "4",
                                id: doc.user.uid,
                                isAvailable: "0",
                                name: driver.name,
                                phone: driver.phone,
                                settings: null,
                                status: null,
                                userPosition: null
                            })
                            .then(() => {
                                this.loading = false;
                                toastr["success"](
                                    this.local[this.lang + ".alerts"]["added"],
                                    this.local[this.lang + ".alerts"]["ok"]
                                );
                            })
                            .catch((error) => {
                                this.loading = false;

                                toastr["error"](
                                    this.local[this.lang + ".alerts"]["error"],
                                    this.local[this.lang + ".alerts"]["err"]
                                );
                            });
                    })
                    .catch((error) => {
                        this.loading = false;
                        toastr["error"](
                            this.local[this.lang + ".alerts"]["error"],
                            this.local[this.lang + ".alerts"]["err"]
                        );
                    });

            },

            clearFields() {
                this.driver.name = this.driver.email = this.driver.phone = this.driver.password = null;
            },
            makeColor(status) {
                let color = 'danger';
                switch (status) {
                    case 1:
                        color = 'warning';
                        break;
                    case 2:
                        color = 'success';
                        break;
                    default:
                        color = 'danger';
                }
                return color;
            }
        }
    };
</script>

<style scoped>
</style>
