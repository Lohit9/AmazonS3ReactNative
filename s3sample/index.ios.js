/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Button = require('react-native-button');
var AWS = require('./lib/aws-sdk.min.js');
console.log("AWS is equal to this: ",AWS);
//var s3 = new AWS.S3();
//var s3 = new AWS.S3({region: 'ap-southeast-2', maxRetries: 15});

var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  button

} = React;

var s3sample = React.createClass({

handlePressUpload()
{

}

handlePressTakePicture()
{

}

handlePressGallery()
{
  
}


render: function() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Click below for image upload
        </Text>
        <Button style={styles.button1} onPress={this.handlePressUpload()}>
          Upload
        </Button>
        <Button style={styles.button2} onPress={this.handlePressTakePicture()}>
          Take Picture
        </Button>
        <Button style={styles.button3} onPress={this.handlePressGallery()}>
          Choose from Gallery
        </Button>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  button3:
  {
    color: 'red',
    padding:100,


  },
  button2:
  {
    color: 'blue',
    padding: 50,
  },
  button1:
  {
    color: 'green',
    padding: 50,


  }

});

AppRegistry.registerComponent('s3sample', () => s3sample);
