<template>
    <div id="app">
        <router-view />
    </div>
</template>

<style>
@font-face {
    font-family: "EasyReadingPRO";
    src: url("~@/assets/fonts/easyreadingpro-webfont.woff2") format("woff2");
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: "EasyReadingPROItalic";
    src: url("~@/assets/fonts/easyreadingproitalic-webfont.woff2")
        format("woff2");
    font-weight: normal;
    font-style: normal;
}

* {
    font-family: "EasyReadingPRO", Helvetica, Arial, sans-serif !important;
}

.is-primary {
    background-color: #953eac !important;
}

#app {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
}
</style>
