import React from 'react';

import '../../stylesheets/Body.css';

class Body extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tab: props.email.body[0].type
    }
  }

  componentWillReceiveProps(nextProps) {
    if(nextProps.email.message_id != this.props.email.message_id) {
      this.setState({ tab: nextProps.email.body[0].type });
    }
  }

  _onTabChange(tab) {
    this.setState({ tab: tab });
  }

  _body() {
    for(let i in this.props.email.body) {
      let body = this.props.email.body[i];
      if(body.type != this.state.tab) {
        continue;
      }
      if(body.type == 'text') {
        return body.content.split('\n').map((p, index) => {
          return <span key={index}>{p}<br /></span>;
        });
      } else {
        return <div dangerouslySetInnerHTML={{__html: body.content}} />
      }
    }
    return null;
  }

  render() {
    let email = this.props.email

    let tabs = email.body.map((body, index) => {
      let classNames = ['body__tab'];
      if(body.type == this.state.tab) {
        classNames.push('body__tab_selected');
      }
      let onClick = this._onTabChange.bind(this, body.type);
      return (
        <div
          key={index}
          className={classNames.join(' ')}
          onClick={onClick}>
          {body.type.toUpperCase()}
        </div>
      );
    });

    let body = this._body()
    return (
      <div className="body">
        <div className="body__tabs">
          {tabs}
        </div>
        <div className="body__content">{body}</div>
      </div>
    );
  }
}

export default Body;
