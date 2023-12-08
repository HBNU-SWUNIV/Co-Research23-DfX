// Auto-generated. Do not edit!

// (in-package kanu_pkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class MarkerInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.rvec = null;
      this.tvec = null;
      this.center_x = null;
      this.center_y = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('rvec')) {
        this.rvec = initObj.rvec
      }
      else {
        this.rvec = [];
      }
      if (initObj.hasOwnProperty('tvec')) {
        this.tvec = initObj.tvec
      }
      else {
        this.tvec = [];
      }
      if (initObj.hasOwnProperty('center_x')) {
        this.center_x = initObj.center_x
      }
      else {
        this.center_x = 0.0;
      }
      if (initObj.hasOwnProperty('center_y')) {
        this.center_y = initObj.center_y
      }
      else {
        this.center_y = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MarkerInfo
    // Serialize message field [id]
    bufferOffset = _serializer.uint32(obj.id, buffer, bufferOffset);
    // Serialize message field [rvec]
    bufferOffset = _arraySerializer.float32(obj.rvec, buffer, bufferOffset, null);
    // Serialize message field [tvec]
    bufferOffset = _arraySerializer.float32(obj.tvec, buffer, bufferOffset, null);
    // Serialize message field [center_x]
    bufferOffset = _serializer.float32(obj.center_x, buffer, bufferOffset);
    // Serialize message field [center_y]
    bufferOffset = _serializer.float32(obj.center_y, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MarkerInfo
    let len;
    let data = new MarkerInfo(null);
    // Deserialize message field [id]
    data.id = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [rvec]
    data.rvec = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [tvec]
    data.tvec = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [center_x]
    data.center_x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [center_y]
    data.center_y = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.rvec.length;
    length += 4 * object.tvec.length;
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'kanu_pkg/MarkerInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7c2d06f36b920e46bab4c11ad2f5b374';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new MarkerInfo(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.rvec !== undefined) {
      resolved.rvec = msg.rvec;
    }
    else {
      resolved.rvec = []
    }

    if (msg.tvec !== undefined) {
      resolved.tvec = msg.tvec;
    }
    else {
      resolved.tvec = []
    }

    if (msg.center_x !== undefined) {
      resolved.center_x = msg.center_x;
    }
    else {
      resolved.center_x = 0.0
    }

    if (msg.center_y !== undefined) {
      resolved.center_y = msg.center_y;
    }
    else {
      resolved.center_y = 0.0
    }

    return resolved;
    }
};

module.exports = MarkerInfo;
