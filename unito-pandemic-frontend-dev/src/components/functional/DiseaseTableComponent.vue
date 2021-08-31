<template>
    <section class="is-padded">
        <h1 class="is-size-4">
            <i class="fas fa-user-md"></i> Diagnosis:
        </h1>
        <br />
        <div>
            <vue-good-table
                :columns="columns"
                :rows="rows"
                :search-options="{
                    enabled: true,
                    trigger: 'enter',
                    skipDiacritics: true,
                    //searchFn: mySearchFn,
                    placeholder: 'Search this table',
                    //externalQuery: searchQuery,
                }"
            />
        </div>
    </section>
</template>

<script>
import "vue-good-table/dist/vue-good-table.css";
import { VueGoodTable } from "vue-good-table";
const axios = require("axios").default;
import { SnackbarProgrammatic as Snackbar } from "buefy";
const moment = require('moment');

// For production
const url = "https://xelinion.servebeer.com:8443/unito-pandemic-rest-backend-1.0/";
// For dev
// const url = "http://localhost:8080/";

export default {
    name: "DiseaseTableComponent",
    data() {
        return {
            diseases: null,
            isEmpty: false,
            isStriped: true,
            isHoverable: true,
            key: null,
            columns: [
                {
                    label: "Id",
                    field: "id"
                },
                {
                    label: "Public Key",
                    field: "pubkey"
                },
                {
                    label: "Disease",
                    field: "disease"
                },
                {
                    label: "Date",
                    field: "date",
                    dateInputFormat: "yyyy/MM/dd",
                    dateOutputFormat: "dd/MM/yyyy"
                },
                {
                    label: "Outcome",
                    field: "outcome"
                }
            ],
            rows: []
        };
    },
    beforeCreate() {
        axios
            .get(url + "api/diseases/all", {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            })
            .then(response => {
                this.diseases = response.data;
            })
            .catch(error => {
                Snackbar.open("Error " + error);
            });
        axios
            .get(url + "api/contagion/all", {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            })
            .then(response => {
                this.key = response.data;

                var i;
                for (i = 0; i < this.key.length; i++) {
                    const diseaseValue = this.getElByPropVal(this.diseases, 
                        this.key[i].diseaseId);
                    const time = moment.unix(this.key[i].timestamp).format("DD-MM-YYYY HH:mm:ss");
                    // const time = new Date(this.key[i].timestamp*1000);

                    this.rows.push(
                        { id: this.key[i].id, pubkey: this.key[i].infected,
                         disease: diseaseValue,
                         date: time,
                         outcome: "Positive" }
                    );
                }
            })
            .catch(error => {
                Snackbar.open("Error " + error);
            });
    },
    methods: {
        color: function(value) {
            return value == "Positive" ? "is-success" : "is-warning";
        },
        getElByPropVal: function(myArray, val){
            for (var i = 0, length = myArray.length; i < length; i++) {
                if (myArray[i].id == val){
                    return myArray[i].name;
                }
            }
        }
    },
    components: {
        VueGoodTable
    }
};
</script>

<style scoped>
.fa,
.far,
.fas {
    font-family: "Font Awesome 5 Free" !important;
}
</style>
