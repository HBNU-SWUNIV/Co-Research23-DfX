// Generated by gencpp from file kanu_pkg/DistServiceMessageResponse.msg
// DO NOT EDIT!


#ifndef KANU_PKG_MESSAGE_DISTSERVICEMESSAGERESPONSE_H
#define KANU_PKG_MESSAGE_DISTSERVICEMESSAGERESPONSE_H


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
struct DistServiceMessageResponse_
{
  typedef DistServiceMessageResponse_<ContainerAllocator> Type;

  DistServiceMessageResponse_()
    : dist(0.0)  {
    }
  DistServiceMessageResponse_(const ContainerAllocator& _alloc)
    : dist(0.0)  {
  (void)_alloc;
    }



   typedef float _dist_type;
  _dist_type dist;





  typedef boost::shared_ptr< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> const> ConstPtr;

}; // struct DistServiceMessageResponse_

typedef ::kanu_pkg::DistServiceMessageResponse_<std::allocator<void> > DistServiceMessageResponse;

typedef boost::shared_ptr< ::kanu_pkg::DistServiceMessageResponse > DistServiceMessageResponsePtr;
typedef boost::shared_ptr< ::kanu_pkg::DistServiceMessageResponse const> DistServiceMessageResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator1> & lhs, const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator2> & rhs)
{
  return lhs.dist == rhs.dist;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator1> & lhs, const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace kanu_pkg

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "4cf5efb292b8e37e249bc3abe7cfd7b3";
  }

  static const char* value(const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x4cf5efb292b8e37eULL;
  static const uint64_t static_value2 = 0x249bc3abe7cfd7b3ULL;
};

template<class ContainerAllocator>
struct DataType< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "kanu_pkg/DistServiceMessageResponse";
  }

  static const char* value(const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 dist\n"
;
  }

  static const char* value(const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.dist);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct DistServiceMessageResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::kanu_pkg::DistServiceMessageResponse_<ContainerAllocator>& v)
  {
    s << indent << "dist: ";
    Printer<float>::stream(s, indent + "  ", v.dist);
  }
};

} // namespace message_operations
} // namespace ros

#endif // KANU_PKG_MESSAGE_DISTSERVICEMESSAGERESPONSE_H