// Generated by gencpp from file kanu_pkg/DistServiceMessageRequest.msg
// DO NOT EDIT!


#ifndef KANU_PKG_MESSAGE_DISTSERVICEMESSAGEREQUEST_H
#define KANU_PKG_MESSAGE_DISTSERVICEMESSAGEREQUEST_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace kanu_pkg
{
template <class ContainerAllocator>
struct DistServiceMessageRequest_
{
  typedef DistServiceMessageRequest_<ContainerAllocator> Type;

  DistServiceMessageRequest_()
    : requestCode(0)  {
    }
  DistServiceMessageRequest_(const ContainerAllocator& _alloc)
    : requestCode(0)  {
  (void)_alloc;
    }



   typedef uint32_t _requestCode_type;
  _requestCode_type requestCode;





  typedef boost::shared_ptr< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> const> ConstPtr;

}; // struct DistServiceMessageRequest_

typedef ::kanu_pkg::DistServiceMessageRequest_<std::allocator<void> > DistServiceMessageRequest;

typedef boost::shared_ptr< ::kanu_pkg::DistServiceMessageRequest > DistServiceMessageRequestPtr;
typedef boost::shared_ptr< ::kanu_pkg::DistServiceMessageRequest const> DistServiceMessageRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator1> & lhs, const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator2> & rhs)
{
  return lhs.requestCode == rhs.requestCode;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator1> & lhs, const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace kanu_pkg

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "271c2fa712f74a38e5c4fe5994fc00e1";
  }

  static const char* value(const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x271c2fa712f74a38ULL;
  static const uint64_t static_value2 = 0xe5c4fe5994fc00e1ULL;
};

template<class ContainerAllocator>
struct DataType< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "kanu_pkg/DistServiceMessageRequest";
  }

  static const char* value(const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "uint32 requestCode\n"
;
  }

  static const char* value(const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.requestCode);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct DistServiceMessageRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::kanu_pkg::DistServiceMessageRequest_<ContainerAllocator>& v)
  {
    s << indent << "requestCode: ";
    Printer<uint32_t>::stream(s, indent + "  ", v.requestCode);
  }
};

} // namespace message_operations
} // namespace ros

#endif // KANU_PKG_MESSAGE_DISTSERVICEMESSAGEREQUEST_H
