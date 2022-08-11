//
//  MapViewController.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/11.
//

import UIKit
import MapKit
//MARK: Location1. 임포트
import CoreLocation

/*
 MapView
 - 지도와 위치 권한은 상관 X
 - 만약 지도에 현재 위치 등을 표현하고 싶다면 위치 권한을 등록해줘야 한다!!!!
 - 중심, 범위 지정
 - 핀(어노테이션)
 */

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Location2. 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Location3. 프로토콜 연결
        locationManager.delegate = self
        
        // 제거 가능한 이유 명확히 알기!
        // checkUserDeviceLocationServiceAuthorization()
        
        //지도 중심 설정: 애플맵 활용해 좌표 복사
        let center = CLLocationCoordinate2D(latitude: 37.650676, longitude: 127.076696)
        setRegionAndAnnotation(center: center)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showRequestLocationServiceAlert()
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        
        
        //지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
        
        //지도에 핀 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "이곳이 은행사거리다"
        mapView.addAnnotation(annotation)
    }
    
}

//MARK: Location4. 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    
    //MARK: Location5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        //ex. 위도 경도 기반으로 날씨 정보 조회 가능
        //ex. 지도를 다시 세팅
        
        
        if let coordinate = locations.last?.coordinate {
        setRegionAndAnnotation(center: coordinate)
            
        }
        //위치 업데이트 멈춰라
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: Location6. 사용자의 위치를 못 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }

}
// 위치 관련된 User Defined Methods
extension MapViewController {
    
    //MARK: Location7. iOS 버전에 따른 분기처리 및 iOS 위치 서비스 활성화 여부 확인
    //위치 서비스가 켜져 있다면 권한을 요청하고, 꺼져 있다면 커스텀 얼럿으로 상황 알려주기
    //CLAuthorizationStatus
    //-denied: 허용 안함 / 설정에서 추후에 거부 / 위치 서비스 비활성화 / 비행기 모드
    //-restricted: 앱 권한 자체가 없는 경우 / 자녀 보호 기능으로 제한
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            //인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴.
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //iOS 위치 서비스 활성화 여부 체크: locationServicesEnabled
        if CLLocationManager.locationServicesEnabled() {
            //위치 서비스가 활성화 되어 있음 => 위치 권한 요청 가능 => 위치 권한을 요청
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어 위치 권한 요청이 불가합니다.")
        }
        
    }
    //MARK: Location8. 사용자의 위치 권한 상태 확인
    //사용자가 위치를 허용했는지, 거부했는지, 아직 선택하지 않았는지 등을 확인(단 사전에 iOS 위치 서비스 활성화 필수 확인!!)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
            
        case .notDetermined:
            print("NOTDETERMINED")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            //plist에 WhenInUse가 등록이 되어야 request를 쓸 수 있다.
            //locationManager.startUpdatingLocation() //명확하게 이해하기!!
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
        
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            //사용자가 위치를 허용해둔 상태라면, startUpdatingLocation를 통해 didUpdateLocations 메서드가 실행됨.
            locationManager.startUpdatingLocation()
            
        default:
            print("DEFAULT")
        }
    }
    
    func showRequestLocationServiceAlert() {
        
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
        
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
          
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    //MARK: Location9. 사용자의 권한 상태가 바뀔 때를 알려줌
    //거부했다가 설정에서 변경했거나, 혹은 notDetermined에서 허용을 했거나 등.
    //중요한 이유: 사용자가 허용을 해서 위치를 가지고 오는 중에, 설정에서 거부하고 돌아온다면??
    
    //iOS 14.0 이상: 사용자의 권한 상태가 변경이 될 때, 위치 관리자 생성할 때 호출됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    //iOS 14.0 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension MapViewController: MKMapViewDelegate {
    
    //    //지도에 커스텀 핀을 추가하는 방법
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        <#code#>
    //    }
    //
        //지도를 움직이다가 멈췄을 때 동작하는 애니메이션
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            locationManager.stopUpdatingLocation()
        }
}
