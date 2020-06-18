<template>
    <div>
        <div class="row">
            <div class="card card-primary card-outline col-12">
                <div class="card-header">
                    <button v-show="acl.create_agents" class="btn btn-success" data-target="#addFeed" data-toggle="modal" type="button">
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
                                <span class="badge badge-info">{{agents.total}}</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr :class="'table-'+makeColor(agent.status)" :key="agent.id"
                            v-for="(agent,index) in agents.data">
                            <td>
                                <img :src="agent.avatar+'?r='+Math.random()" class="rounded-circle mx-1" width="24px"/>
                                {{ agent.name }}
                            </td>
                            <td>{{agent.email}}</td>
                            <td>{{agent.phone}}</td>
                            <td>{{agent.created_at | moment("from", "now")}}</td>
                            <td>
                                <img :src="agent.refID.avatar+'?r='+Math.random()" class="rounded-circle mx-1" width="24px"/>
                                {{agent.refID.name}}
                            </td>
                            <td>
                                <span v-show="acl.agents_edit_trash">
                                    <button
                                        @click="editagent(agent)"
                                        class="btn btn-sm btn-info text-white"
                                        type="button" v-show="agent.status==0">
                                    <i class="fa fa-edit"></i>
                                    </button>
                                    <button @click="removeAgent(agent)" class="btn btn-sm btn-danger" type="button"
                                            v-show="agent.status==0">
                                        <i class="fa fa-trash"></i>
                                    </button>

                                </span>
                                <span v-show="acl.agents_approve">
                                    <button @click="approve(agent,index)" class="btn btn-sm btn-success"
                                            title="Create a dashboard account" type="button"
                                            v-show="agent.status==0">
                                        <i class="fas fa-tachometer-alt"></i>
                                    </button>
                                </span>
                                <span v-show="acl.agents_activate">
                                    <button @click="activate(agent,index)" class="btn btn-sm btn-success"
                                            title="Create a mobile app account" type="button"
                                            v-show="agent.status==1">
                                        <i class="fas fa-mobile-alt"></i>
                                    </button>
                                </span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <hr/>
                    <div class="p-2">
                        <pagination :data="Object.assign({},agents)" @pagination-change-page="getResults"></pagination>
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
                            v-show="agent.id==null"
                        >{{ local[lang+".members"]["create-new"] }}</h4>
                        <h4
                            class="modal-title w-100 font-weight-bold"
                            v-show="agent.id!=null"
                        >{{ local[lang+".members"]["edit-item"] }}</h4>
                        <button aria-label="Close" class="close" data-dismiss="modal" type="button">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form @submit.prevent="addEditagent">
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
                                    v-model="agent.name"
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
                                    v-model="agent.email"
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
                                    v-model="agent.phone"
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
                                    :required="agent.id==null"
                                    class="form-control"
                                    type="password"
                                    v-model="agent.password"
                                />
                            </div>
                            <div class="text-danger" v-if="errors && errors.password">{{ errors.password[0] }}</div>
                            <div class="input-group mt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-building"></i>
                                    </span>
                                </div>
                                <select class="form-control" v-model="agent.ref">
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
        name: "AgentComponent",
        props: ["auth", "lang", "acl", "firms"],
        data() {
            return {
                path: CONFIG.PATH,
                loading: false,
                agents: [],
                local: CONFIG.LANG,
                index: null,
                agent: {
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
                        "agents?page=" +
                        page +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.agents = res.data;
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
                        "search/agents?page=" +
                        page +
                        "&keywords=" +
                        this.keywords +
                        "&api_token=" +
                        this.auth.api_token
                    )
                    .then(res => {
                        this.agents = res.data;
                        this.loading = false;
                    });
            },
            addEditagent(agent = null) {
                this.loading = true;
                if (this.agent.id) {
                    axios
                        .put(
                            CONFIG.API_URL +
                            "agents/" +
                            this.agent.id +
                            "?api_token=" +
                            this.auth.api_token,
                            this.agent
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
                            CONFIG.API_URL + "agents" + "?api_token=" + this.auth.api_token,
                            this.agent
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
            editagent(agent) {
                this.agent.id = agent.id;
                this.agent.name = agent.name;
                this.agent.email = agent.email;
                this.agent.phone = agent.phone;
                this.agent.ref = agent.ref;
                $("#addFeed").modal("show");
            },
            removeAgent(agent) {
                var conf = confirm(this.local[this.lang + ".alerts"]["confirm-delete"]);
                if (conf) {
                    this.loading = false;
                    axios
                        .delete(
                            CONFIG.API_URL +
                            "agents/" +
                            agent.id +
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
            approve(agent, index) {
                this.loading = true;
                axios.post(
                    CONFIG.API_URL + "approve/agent" + "?api_token=" + this.auth.api_token,
                    agent
                )
                    .then(res => {
                        this.loading = false;
                        toastr["success"](
                            this.local[this.lang + ".alerts"]["added"],
                            this.local[this.lang + ".alerts"]["ok"]
                        );
                        this.agents.data[index].status = 1;

                    })
                    .catch(error => {
                        console.log(error);
                        this.loading = false;
                        toastr["error"](
                            this.local[this.lang + ".alerts"]["error"],
                            this.local[this.lang + ".alerts"]["err"]
                        );
                    });
            },
            activate(agent, index) {
                axios.post(
                    CONFIG.API_URL + "activate/agent" + "?api_token=" + this.auth.api_token,
                    agent
                ).then(res => {
                    this.agents.data[index].status = 2;
                });
                this.loading = true;
                var today = new Date();
                const query = CONFIG.DB.collection('users')
                    .doc(agent.uid)
                    .set({
                        avatarURL: agent.avatar,
                        email: agent.email,
                        firmID:agent.ref,
                        agentID: null,
                        groupID: "3",
                        id: agent.uid,
                        isAvailable: "0",
                        name: agent.name,
                        phone: agent.phone,
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


            },

            clearFields() {
                this.agent.name = this.agent.email = this.agent.phone = this.agent.password = null;
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
