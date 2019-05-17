import React from 'react';

import Firebase from 'firebase';
import config from './config';


class App extends React.Component {

  constructor(props){
    super(props);
    Firebase.initializeApp(config.firebase);

    this.state = {
      developers: []
    }
  }
