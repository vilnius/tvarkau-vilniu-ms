import React from "react"

import {Row, Col} from 'antd';

export default class RootLayout extends React.Component {

    render() {
        return (
            <div>
                <Row>
                    <Col span={4}><div>Menu goes here</div></Col>
                    <Col span={20}>{this.props.children}</Col>
                </Row>
            </div>
        )
    }

}
