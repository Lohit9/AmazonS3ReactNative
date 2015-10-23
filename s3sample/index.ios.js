/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Button = require('react-native-button');


var {
  AppRegistry,
  StyleSheet,
  Text,
  Component,
  View,
  button

} = React;

class s3sample extends Component {

handlePressUpload()
{

}

handlePressTakePicture()
{

}

handlePressGallery()
{

}





render() {
    return (
      <View style={styles.container}>

        <Button style={styles.button1} onPress={this.handlePressUpload()}>
          Upload
        </Button>
        <Button style={styles.button2} onPress={this.handlePressTakePicture()}>
          Take Picture
        </Button>
        <Button style={styles.button3} onPress={this.handlePressGallery()}>
          Gallery
        </Button>
      </View>
    );
  }
}

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  button3:
  {
    color: 'red',
    padding:50,


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
