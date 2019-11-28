<!DOCTYPE html>
<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub
</script>

<html>

<head>
  <title></title>
  <link rel="stylesheet" href="https://openlayers.org/en/v4.6.5/css/ol.css" type="text/css">
  <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
  <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
  <script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>
  <script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

  <style>
      .ol-popup {
        position: absolute;
        background-color: white;
        -webkit-filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
        filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
        padding: 15px;
        border-radius: 10px;
        border: 1px solid #cccccc;
        bottom: 12px;
        left: -50px;
        min-width: 280px;
      }
      .ol-popup:after, .ol-popup:before {
        top: 100%;
        border: solid transparent;
        content: " ";
        height: 0;
        width: 0;
        position: absolute;
        pointer-events: none;
      }
      .ol-popup:after {
        border-top-color: white;
        border-width: 10px;
        left: 48px;
        margin-left: -10px;
      }
      .ol-popup:before {
        border-top-color: #cccccc;
        border-width: 11px;
        left: 48px;
        margin-left: -11px;
      }
      .ol-popup-closer {
        text-decoration: none;
        position: absolute;
        top: 5px;
        right: 8px;
      }
      .ol-popup-closer:after {
        content: "✖";
      }
	
  </style>
</head>

<body>
  <div style="display: none;">
    <!-- Popup -->
 
 
  </div>
  <div id="map" class="map"></div>
      <div id="popup" class="ol-popup">
      <a href="#" id="popup-closer" class="ol-popup-closer"></a>
      <div id="popup-content"></div>
    </div>
    <label>Geometri type &nbsp;</label>
    <select id="layer-select">
      <option value="AerialWithLabels" selected>Aerial with labels</option>
    </select>
    <select id="type">
      <option value="Point">Kapı</option>
      <option value="Polygon">Mahalle</option>
    </select>
  <script>
  
  
  var container = document.getElementById('popup');
      var content = document.getElementById('popup-content');
      var closer = document.getElementById('popup-closer');


      /**
       * Create an overlay to anchor the popup to the map.
       */
      var overlay = new ol.Overlay(/** @type {olx.OverlayOptions} */ ({
        element: container,
        autoPan: true,
        autoPanAnimation: {
          duration: 250
        }
      }));

	        /**
       * Add a click handler to hide the popup.
       * @return {boolean} Don't follow the href.
       */
      closer.onclick = function() {
        overlay.setPosition(undefined);
        closer.blur();
        return false;
      };
	  
	  

  
    var styles = [
      'AerialWithLabels',
    ];
    var layers = [];
    var i, ii;
    for (i = 0, ii = styles.length; i < ii; ++i) {
      layers.push(new ol.layer.Tile({
        visible: false,
        preload: Infinity,
        source: new ol.source.BingMaps({
          key: 'AkzjdfdB3vW1MDr1awIliM6P2_4veA0DVub1jAk83Vz_i0M_2ErTwvLeQ-JZlPvY',
          imagerySet: styles[i]
          // use maxZoom 19 to see stretched tiles instead of the BingMaps
          // "no photos at this zoom level" tiles
          // maxZoom: 19
        })
      }));
    }
		var center = ol.proj.fromLonLat([35.5, 39]);

            var cizimKatmani = new ol.layer.Vector({
                source: new ol.source.Vector()
            });
            layers.push(cizimKatmani);
		
    var map = new ol.Map({
      layers: layers,
   
      loadTilesWhileInteracting: true,
      target: 'map',
	   overlays: [overlay],
      view: new ol.View({
        center: ol.proj.fromLonLat([32.866287, 39.925533]),
        zoom: 6
      })
    });
	
	
	      
  
	
	
var features = new ol.Collection();

var featureOverlay = new ol.layer.Vector({
    source: new ol.source.Vector({features: features}),
    style: new ol.style.Style({
        fill: new ol.style.Fill({
            color: 'rgba(255, 255, 255, 0.2)'}),
        stroke: new ol.style.Stroke({
            color: '#ffcc33',
            width: 2}),
        image: new ol.style.Circle({
            radius: 7,
            fill: new ol.style.Fill({
              color: '#ffcc33'})
         })
    })
});

featureOverlay.setMap(map);
    var select = document.getElementById('layer-select');
    function onChange() {
      var style = select.value;
      for (var i = 0, ii = layers.length; i < ii; ++i) {
        layers[i].setVisible(styles[i] === style);
      }
    }
    select.addEventListener('change', onChange);
    onChange();
  




    var raster = new ol.layer.Tile({
      source: new ol.source.OSM()
    });

    var source = new ol.source.Vector();
    var vector = new ol.layer.Vector({
      source:source ,
      style: new ol.style.Style({
        fill: new ol.style.Fill({
          color: 'rgba(255, 255, 255, 0.2)'
        }),
        stroke: new ol.style.Stroke({
          color: '#ffcc33',
          width: 2
        }),
        image: new ol.style.Circle({
          radius: 7,
          fill: new ol.style.Fill({
            color: '#ffcc33'
          })
        })
      })
    });

     

    var modify = new ol.interaction.Modify({ source: source });
    map.addInteraction(modify);

	
    var  draw,snap; // global so we can remove them later
    var typeSelect = document.getElementById('type');
	
var isa = 0;
	 
	 	map.on('click',function (evt) {
			

			

    }); 
	
    function addInteractions(evt) {
	
        draw = new ol.interaction.Draw({
          features: features,
          type: typeSelect.value
        });
        map.addInteraction(draw);
        snap = new ol.interaction.Snap({source: source});
        map.addInteraction(snap);
		
		var counter = 0;
            var drawcoor = [];
            var temp;

        
		
        draw.on('drawend',function(evt) {
			 var format = new ol.format.WKT();
                var selFeatureWkt = format.writeGeometry(evt.feature.getGeometry(), {
                    dataProjection: 'EPSG:4326',
                    featureProjection: 'EPSG:3857'
                });
		       						//var coordinate = evt.coordinate;
		 //var hdms = ol.proj.transform(coordinate,'EPSG:3857', 'EPSG:4326');
                var url = "/Handler.ashx?f=mahalleekle&mahalleAdi=ABC&WKT=" + selFeatureWkt;
                 $.ajax({
                     url: url, success: function (result) {
                        
                        alert(result);
                    }
                });
            
            alert(selFeatureWkt);



            //-------------------------------------------
            var feature = evt.feature;
var geometry = feature.getGeometry();

var startCoord = geometry.getFirstCoordinate();
var endCoord = geometry.getLastCoordinate();

			content.innerHTML = '<br></br>Mahalle <input type="mahalle" placeholder="Mahalleyi giriniz">Kapı<input type="kapi-no" placeholder="Kapı no giriniz"><button onclick=>Vazgec</button><button onclick=>Kaydet</button><br><br></br>Koordinat bilgileri:<br><code>'  +endCoord+
				'</code>';
            overlay.setPosition(endCoord);


			
		});
	
	};
	 //draw.on('drawend', function (){
	//alert("dawsd"); });


    /**
     * Handle change event.
     */
    typeSelect.onchange = function () {//polgon çiz
      map.removeInteraction(draw);
      map.removeInteraction(snap);
        addInteractions();

	  
    };
	
    addInteractions();
            var url = "/Handler.ashx?f=mahalleleriGetir";
            var mahalleDizi = [];
            var vectorMahalle = null;
            $.ajax({
                url: url,
                success: function (result) {
                    var sonuc = JSON.parse(result);
                    var format = new ol.format.WKT();

                    var denemeFeature = null;
                    for (var i = 0; i < sonuc.length; i++) {
                        var feature = format.readFeature(sonuc[i].WKT, {
                            dataProjection: 'EPSG:4326',
                            featureProjection: 'EPSG:3857'
                        });
                        //feature.set('MahalleAdi', sonuc[i].MahalleAdi);
                        //feature.set('MahalleId', sonuc[i].Id);
                        mahalleDizi.push(feature);
                    }
                    vectorMahalle = new ol.layer.Vector({
                        source: new ol.source.Vector({
                            features: mahalleDizi
                        })
                    });
                    map.addLayer(vectorMahalle);
                }
            });

	

	
  </script>

</body>

</html>