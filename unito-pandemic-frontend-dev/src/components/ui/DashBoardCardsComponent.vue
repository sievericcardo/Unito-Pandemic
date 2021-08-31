<template>
    <section>
        <h1 class="is-size-4">
            <i class="far fa-address-card"></i> Report:
        </h1>
        <br />
        <div class="columns">
            <div class="column is-one-third">
                <div class="tile">
                    <div class="tile is-parent is-vertical">
                        <article class="tile is-child notification is-primary">
                            <img
                                src="@/assets/images/group.png"
                                alt="Smiley face"
                                height="72"
                                width="72"
                            />
                            <p class="subtitle">Total Registered Users</p>
                            <span>{{this.users}}</span>
                        </article>
                    </div>
                </div>
                <br />
                <div class="tile">
                    <div class="tile is-parent is-vertical">
                        <article class="tile is-child notification is-warning">
                            <img
                                src="@/assets/images/doctor.png"
                                alt="Smiley face"
                                height="72"
                                width="72"
                            />
                            <p class="subtitle">Registered doctors</p>
                            <span>{{this.researchers}}</span>
                        </article>
                    </div>
                </div>
            </div>
            <div class="column is-one-third">
                <div class="tile">
                    <div class="tile is-parent is-vertical">
                        <article class="tile is-child notification is-primary">
                            <img
                                src="@/assets/images/coronavirus.png"
                                alt="Smiley face"
                                height="72"
                                width="72"
                            />
                            <p class="subtitle">Number of known diseases</p>
                            <span>{{this.diseases}}</span>
                        </article>
                    </div>
                </div>
                <br />
                <div class="tile">
                    <div class="tile is-parent is-vertical">
                        <article class="tile is-child notification is-warning">
                            <img
                                src="@/assets/images/report.png"
                                alt="Smiley face"
                                height="72"
                                width="72"
                            />
                            <p class="subtitle">Medical reports</p>
                            <span>{{this.contagions}}</span>
                        </article>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
const axios = require("axios").default;
import { SnackbarProgrammatic as Snackbar } from "buefy";

// For production
const url = "https://xelinion.servebeer.com:8443/unito-pandemic-rest-backend-1.0/";
// For dev
// const url = "http://localhost:8080/";

export default {
    name: "DashBoardCardsComponent",
    data() {
        return {
            researchers: 0,
            users: 0,
            diseases: 0,
            contagions: 0
        };
    },
    created: function() {
        //axios request for magic numbers

        axios
            .get(url + "api/backofficeuser/magic", {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            })
            .then(response => {
                this.researchers = response.data.researchers;
                this.users = response.data.registered;
                this.diseases = response.data.diseases;
                this.contagions = response.data.contagions;
            })
            .catch(error => {
                Snackbar.open("Error " + error);
            });
    }
};
</script>

<style scoped>
.is-padded {
    padding: 2rem;
    padding-top: 0 !important;
}

.tile {
    box-shadow: 0px 0px 4px 1px rgba(158, 158, 158, 0.3);
    border-radius: 0.5rem;
}

.is-parent {
    padding: 0 !important;
}

.fa,
.far,
.fas {
    font-family: "Font Awesome 5 Free" !important;
}
</style>
