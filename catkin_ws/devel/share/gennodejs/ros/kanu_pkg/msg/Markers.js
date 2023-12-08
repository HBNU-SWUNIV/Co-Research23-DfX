// Auto-generated. Do not edit!

// (in-package kanu_pkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let MarkerInfo = require('./MarkerInfo.js');

//-----------------------------------------------------------

class Markers {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.marker_info = null;
    }
    else {
      if (initObj.hasOwnProperty('marker_info')) {
        this.marker_info = initObj.marker_info
      }
      else {
        this.marker_info = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Markers
    // Serialize message field [marker_info]
    // Serialize the length for message field [marker_info]
    bufferOffset = _serializer.uint32(obj.marker_info.length, buffer, bufferOffset);
    obj.marker_info.forEach((val) => {
      bufferOffset = MarkerInfo.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Markers
    let len;
    let data = new Markers(null);
    // Deserialize message field [marker_info]
    // Deserialize array length for message field [marker_info]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.marker_info = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.marker_info[i] = MarkerInfo.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.marker_info.forEach((val) => {
      length += MarkerInfo.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'kanu_pkg/Markers';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '233e0e9eb1ef4e1d8dc45028904252ed';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    MarkerInfo[] marker_info
    ================================================================================
    MSG: kanu_pkg/MarkerInfo
    uint32 id
    float32[] rvec
    float32[] tvec
    float32 center_x
    float32 center_y
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Markers(null);
    if (msg.marker_info !== undefined) {
      resolved.marker_info = new Array(msg.marker_info.length);
      for (let i = 0; i < resolved.marker_info.length; ++i) {
        resolved.marker_info[i] = MarkerInfo.Resolve(msg.marker_info[i]);
      }
    }
    else {
      resolved.marker_info = []
    }

    return resolved;
    }
};

module.exports = Markers;
