# Co-Research23
# 한밭대 컴퓨터공학과 DfX팀

**팀 구성**
 - 20207119 김현태
 - 20197130 전수진
 - 30231216 이보석

## Teamate Project Background
- ### 필요성
  - 양돈 농가의 고량화와 생산 고정비 증가로 인한 비용 절감 및 관리의 편리성을 위한 새로운 기술 도입이 요구되고있음. 

  - 돼지의 생물학적 특성 상 일정한 수준의 온도 및 습도 관리가 필요하나, 야간 등 양돈가 근무 인력이 상주하지 않는 시간으로 인해 모니터링 사각지대가 발생하고있음.

  - 양돈 농가의 생산성 향상을 위하 다양한 스마트팜 기술이 도입되고 있으나 단순 세서 제어 등을 이용한 돈사 환경에 대한 스마트팜 모델로서 존재함.

  - 돈사 내부 모니터링을 위한 CCTV 설치 비용한 약 2,000 ~ 3,000만원이며, 돈사 전체 모니터링 시스템 구축 시 과다 비용 발생.

- ### 기존 해결책의 문제점
  - CCTV를 대체한 영상 수집 장치 또한 돈사 환경에서 설치 비용과 관리가 매우 어려움

  - 위와 같은 문제를 최소화하고자, 돈사 작업 환경에서 모니터링을 수행할 수 있는 모바일 로봇 프로토 타입을 제작하고 모니터링에 필요한 알고리즘 및 시스템을 개발하고자 함.
  
## System Design
  - ### System Requirements
    - SBC : Jetson Nano Development Kit

    - Controller : OpenCR 1.0(MCU:32-bit ARM Cortex®-M7 with FPU (216MHz, 462DMIPS))

    - Camera : Intel Realsense D435

    - Actuator : Robotis Dynamixel XM430-W350-T 
      - EEPROM Area : Address(1 Byte) - 7(ID : 1, 2), 12(Secondary ID : 1, 2) 
                      Baud Rate(1 Byte) - 3, 


    - OS : Ubuntu 18.04(Jetpack SDK 4.6)

    - Program Language : Python(>= 3.6.0)

    - Dependency Package : Opencv 4.6.0(Cmake installation required), librealsense SDK, ROS Melodic

    - SMPS : MEAN WELL LRS 100-12

    - 3D Printer / Filament : Flashforge Creator 3 / PLA+ 1.75mm
      - Nozzle Temp : 220(℃), Plate Bed(60℃), Height Stack : 0.2(mm), Infill : 15%, Spped : 50(mm/s)
      - Print Environment - Temp : 18℃ ~ 20℃, Absolute Humidity : 40%
    
## Case Study
  - ### Description
    - 표윤석, 조한철, 정려운, 임태훈(2017, 11), “ROS 개발환경 구축”,「ROS 로봇 프로그래밍」, 루비페이퍼
    - Alexey Spizhevoy, Aleksandr Rynnikov(2018, 3), “Multiple View Geometry”, 「Opencv 3 Computer Vision with Python Cookbook」, Packt Publishing
  
  
## Conclusion
- 모바일 로봇 프로토 타입 제작  
  - 3D 모델링을 통해 모바일 로봇 프로토 타입을 설계하고, 3D 프린터로 모바일 로봇 프레임을 제작함.

- 모바일 로봇 본체부(3D/ 2D)

  <img width="409" alt="Car_body_3d" src="https://github.com/HBNU-SWUNIV/Co-Research23-DfX/assets/51081763/59c0bb4b-c0d2-4da3-a98b-bd7d37371111">
  <img width="409" img height="308" alt="Car_body_2D" src="https://github.com/HBNU-SWUNIV/Co-Research23-DfX/assets/51081763/03944ed4-024d-4e01-bb07-c1f535564f89">

- 모바일 로봇 덮개부(3D/ 2D)

  <img width="409" alt="Car_top_3D" src="https://github.com/HBNU-SWUNIV/Co-Research23-DfX/assets/51081763/ebf42eb5-1129-40e4-893e-ca4169a29527">
  <img width="409" img height="262" alt="Car_plate_2D" src="https://github.com/HBNU-SWUNIV/Co-Research23-DfX/assets/51081763/39302122-31d7-47d9-9948-db3034725817">

- 모바일 로봇(알고리즘 테스트용 / 프로토 타입)

  <img width="818" alt="사진2" src="https://github.com/HBNU-SWUNIV/Co-Research23-DfX/assets/51081763/1580b0fc-9f42-4a28-bb45-a4b4cffb5154">

- 모바일 로봇 충전 및 제어를 위한 소형회된 무인 충전 스테이션 구현
  - 무인 충전 스테이션 내 마그네틱 접촉체를 포고핀을 선정했고, 충전 시 과전류로 인한 모바일 로봇의 고장 가능성을 고려해 최대 10A 전류를 지원하는 포고핀으로 선정함.

  - 포고핀은 각 하나씩 스테이션과 모바일 로봇에 장착했으며, 충전 스테이션 내 외부 전원 공급 장치를 통해 모바일 로봇 배터리의 최대 용량을 고려해 12VDC로 충전 전압을 설정함. 

- 충전 스테이션 프로토 타입

    <img width="818" alt="사진3" src="https://github.com/HBNU-SWUNIV/Co-Research23-DfX/assets/51081763/dbc5b002-fea8-42b1-9967-4108f88d4b47">


- 정밀 주행을 위한 주행 보정 및 충전 스테이션 이동 알고리즘 구현
  - 모바일 로봇에 장착한 RGB-D 카메라와 충전 스테이션의 마커에 x, y, z축의 자세 정보를 생성하고, 모바일 로봇이 스테이션의 마커의 자세에 맞게 조향제어를 수행함.

- 구동 영상

  <img width="818" alt="output1" src="https://github.com/HBNU-SWUNIV/Co-Research23-DfX/assets/51081763/2ada3516-404d-4bb5-a93b-6336059ec21b">

## Project Outcome
