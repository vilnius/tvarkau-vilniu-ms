import React from "react"
import ReactDOM from "react-dom"
import {Router, Route, IndexRoute, hashHistory} from "react-router"
import {Provider} from "react-redux"

import store from "./store"
import RootLayout from "./components/RootLayout"
import Landing from "./components/Landing"

import enUS from 'antd/lib/locale-provider/en_US';
import {LocaleProvider} from 'antd'

const app = document.getElementById("app")

ReactDOM.render(
    <LocaleProvider locale={enUS}>
        <Provider store={store}>
            <Router history={hashHistory}>
                <Route path="/" component={RootLayout}>
                    <IndexRoute component={Landing}/>
                </Route>
            </Router>
        </Provider>
    </LocaleProvider>
    , app);
