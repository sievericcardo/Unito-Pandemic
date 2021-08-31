<template>
    <b-navbar class="is-primary">
        <template slot="brand">
            <b-navbar-item tag="router-link" :to="{ path: '/' }">
                <img src="@/assets/images/logo.png" />
            </b-navbar-item>
        </template>
        <template slot="start">
            <b-navbar-item tag="router-link" :to="{ path: '/' }">
                <h1 class="is-white is-size-4">Unito Pandemic</h1>
            </b-navbar-item>
            <b-navbar-item tag="router-link" :to="{ path: '/dashboard' }">
                <h1 class="is-white is-size-5">Dashboard</h1>
            </b-navbar-item>
        </template>
    </b-navbar>
</template>

<script>
export default {
    name: "TheNavbar"
};
</script>

<style scoped>
.navbar-item:hover {
    background-color: #771690;
}

.is-white {
    color: white;
}
</style>
