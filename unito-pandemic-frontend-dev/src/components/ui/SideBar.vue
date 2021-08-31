<template>
    <aside class="menu is-padded">
        <p class="menu-label">General</p>
        <ul class="menu-list">
            <li v-bind:class="{ activemenu: this.report }">
                <a @click="setReport()">
                    <i class="far fa-address-card"></i> Report
                </a>
            </li>
        </ul>
        <p class="menu-label">
            <i class="fas fa-briefcase-medical"></i> Healthcare
        </p>
        <ul class="menu-list">
            <li v-bind:class="{ activemenu: this.diagnosis }">
                <a @click="setDiagnosis()">
                    <i class="fas fa-user-md"></i> Diagnosis
                </a>
            </li>
            <li v-bind:class="{ activemenu: this.diseases_zone }">
                <a @click="setDiseasesZone()">
                    <i class="fas fa-microscope"></i> Diseases Zone
                </a>
            </li>
        </ul>
        <p class="menu-label">
            <i class="fas fa-wrench"></i> Administration
        </p>
        <ul class="menu-list">
            <li v-bind:class="{ activemenu: this.roles }">
                <a @click="setRoles()">
                    <i class="fas fa-users"></i> Roles
                </a>
            </li>
            <li v-bind:class="{ activemenu: this.diseases }">
                <a @click="setDiseases()">
                    <i class="fas fa-viruses"></i> Diseases
                </a>
            </li>
            <!-- <li>
                <a>
                    <i class="fas fa-dice-four"></i> Probabilities
                </a>
            </li>-->
        </ul>
        <p class="menu-label">
            <i class="fas fa-project-diagram"></i> Dataviz Zone
        </p>
        <ul class="menu-list">
            <li v-bind:class="{ activemenu: this.graph_1 }">
                <a @click="setGraph1()">
                    <i class="fas fa-chart-pie"></i> Graph1
                </a>
            </li>
            <li v-bind:class="{ activemenu: this.graph_2 }">
                <a @click="setGraph2()">
                    <i class="fas fa-chart-bar"></i> Graph2
                </a>
            </li>
            <li v-bind:class="{ activemenu: this.graph_3 }">
                <a @click="setGraph3()">
                    <i class="fas fa-chart-line"></i> Graph3
                </a>
            </li>
        </ul>
        <p class="menu-label">
            <i class="fa fa-cog"></i> Others
        </p>
        <ul class="menu-list">
            <li>
                <a @click="logout()">
                    <i class="fa fa-sign-out"></i> Logout
                </a>
            </li>
        </ul>
    </aside>
</template>

<script>
import router from "../../router";
import { SnackbarProgrammatic as Snackbar } from "buefy";

export default {
    name: "SideBar",
    data() {
        return {
            report: true,
            diagnosis: false,
            diseases_zone: false,
            roles: false,
            diseases: false,
            graph_1: false,
            graph_2: false,
            graph_3: false
        };
    },
    methods: {
        setReport() {
            this.$root.$emit("report", !this.report);
            this.report = !this.report;
        },
        setDiagnosis() {
            this.$root.$emit("diagnosis", !this.diagnosis);
            this.diagnosis = !this.diagnosis;
        },
        setDiseasesZone() {
            this.$root.$emit("diseases_zone", !this.diseases_zone);
            this.diseases_zone = !this.diseases_zone;
        },
        setRoles() {
            this.$root.$emit("roles", !this.roles);
            this.roles = !this.roles;
        },
        setDiseases() {
            this.$root.$emit("diseases", !this.diseases);
            this.diseases = !this.diseases;
        },
        setGraph1() {
            this.$root.$emit("graph_1", !this.graph_1);
            this.graph_1 = !this.graph_1;
        },
        setGraph2() {
            this.$root.$emit("graph_2", !this.graph_2);
            this.graph_2 = !this.graph_2;
        },
        setGraph3() {
            this.$root.$emit("graph_3", !this.graph_3);
            this.graph_3 = !this.graph_3;
        },
        logout() {
            Snackbar.open("See you soon");
            localStorage.removeItem("jwt");
            setTimeout(() => {
                router.replace("/");
            }, 400);
        }
    }
};
</script>

<style scoped>
.activemenu {
    background-color: rgba(240, 240, 240, 0.7);
}

.is-padded {
    padding: 1rem !important;
}

.fa,
.far,
.fas {
    font-family: "Font Awesome 5 Free" !important;
}
</style>
