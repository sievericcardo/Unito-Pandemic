<template>
    <div>
        <TheNavbar />
        <div class="columns">
            <div class="column is-one-fifth is-padded-menu">
                <SideBar />
            </div>
            <div class="column is-padded-cards">
                <DashBoardCardsComponent v-if="report" />
                <br v-if="report" />
                <DiseaseTableComponent v-if="diagnosis" />
                <br v-if="diagnosis" />
                <NewTestOutcomeComponent v-if="diseases_zone" />
                <br v-if="diseases_zone" />
                <RolesComponent v-if="roles" />
                <br v-if="roles" />
                <DiseasesComponent v-if="diseases" />
                <br v-if="diseases" />
            </div>
        </div>
        <TheFooter />
    </div>
</template>

<script>
import TheNavbar from "../ui/TheNavbar";
import TheFooter from "../ui/TheFooter";
import SideBar from "../ui/SideBar";
import DashBoardCardsComponent from "../ui/DashBoardCardsComponent";
import DiseaseTableComponent from "../functional/DiseaseTableComponent";
import NewTestOutcomeComponent from "../functional/NewTestOutcomeComponent";
import RolesComponent from "../functional/RolesComponent";
import DiseasesComponent from "../functional/DiseasesComponent";
import router from "../../router";

export default {
    name: "DashBoard",
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
    components: {
        TheNavbar,
        TheFooter,
        SideBar,
        DashBoardCardsComponent,
        DiseaseTableComponent,
        NewTestOutcomeComponent,
        RolesComponent,
        DiseasesComponent
    },
    created: function() {
        //login check
        if (localStorage.getItem("jwt") == null) {
            router.push("/");
        }

        this.$root.$on("report", data => {
            //console.log(data);
            this.report = data;
        });
        this.$root.$on("diagnosis", data => {
            //console.log(data);
            this.diagnosis = data;
        });
        this.$root.$on("diseases_zone", data => {
            //console.log(data);
            this.diseases_zone = data;
        });
        this.$root.$on("roles", data => {
            //console.log(data);
            this.roles = data;
        });
        this.$root.$on("diseases", data => {
            //console.log(data);
            this.diseases = data;
        });
        this.$root.$on("graph_1", data => {
            //console.log(data);
            this.graph_1 = data;
        });
        this.$root.$on("graph_2", data => {
            //console.log(data);
            this.graph_2 = data;
        });
        this.$root.$on("graph_3", data => {
            //console.log(data);
            this.graph_3 = data;
        });
    }
};
</script>

<style scoped>
.is-padded-cards {
    padding: 4rem;
}

.is-padded-menu {
    padding-top: 2rem !important;
}

.fa,
.far,
.fas {
    font-family: "Font Awesome 5 Free" !important;
}
</style>
