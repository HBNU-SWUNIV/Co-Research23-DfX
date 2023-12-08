// Auto-generated. Do not edit!

// (in-package kanu_pkg.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class DistServiceMessageRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.requestCode = null;
    }
    else {
      if (initObj.hasOwnProperty('requestCode')) {
        this.requestCode = initObj.requestCode
      }
      else {
        this.requestCode = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DistServiceMessageRequest
    // Serialize message field [requestCode]
    bufferOffset = _serializer.uint32(obj.requestCode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DistServiceMessageRequest
    let len;
    let data = new DistServiceMessageRequest(null);
    // Deserialize message field [requestCode]
    data.requestCode = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kanu_pkg/DistServiceMessageRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '271c2fa712f74a38e5c4fe5994fc00e1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 requestCode
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DistServiceMessageRequest(null);
    if (msg.requestCode !== undefined) {
      resolved.requestCode = msg.requestCode;
    }
    else {
      resolved.requestCode = 0
    }

    return resolved;
    }
};

class DistServiceMessageResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.dist = null;
    }
    else {
      if (initObj.hasOwnProperty('dist')) {
        this.dist = initObj.dist
      }
      else {
        this.dist = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DistServiceMessageResponse
    // Serialize message field [dist]
    bufferOffset = _serializer.float32(obj.dist, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DistServiceMessageResponse
    let len;
    let data = new DistServiceMessageResponse(null);
    // Deserialize message field [dist]
    data.dist = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kanu_pkg/DistServiceMessageResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4cf5efb292b8e37e249bc3abe7cfd7b3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 dist
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DistServiceMessageResponse(null);
    if (msg.dist !== undefined) {
      resolved.dist = msg.dist;
    }
    else {
      resolved.dist = 0.0
    }

    return resolved;
    }
};

module.exports = {
  Request: DistServiceMessageRequest,
  Response: DistServiceMessageResponse,
  md5sum() { return '81921970ef6bbdc458ce6f038299ceae'; },
  datatype() { return 'kanu_pkg/DistServiceMessage'; }
};
