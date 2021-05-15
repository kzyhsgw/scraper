function initMap(){
  console.log('Change');
  const display = document.getElementById('display')
  let geocoder = new google.maps.Geocoder()

  function inputChange(){
    console.log('Change');
    let inputAddress = document.getElementById('exhibition_place_1').value;
    geocoder.geocode( { 'address': inputAddress}, function(results, status) {
      if (status == 'OK') {
        display.textContent = "緯度：" + results[ 0 ].geometry.location.lat() + "経度：" + results[ 0 ].geometry.location.lng()
      } else {
        alert('該当する結果がありませんでした：' + status);
      }
    });
  }
}