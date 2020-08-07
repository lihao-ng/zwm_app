//  return Container(
//       child: Echarts(
//         extensions: [MalaysiaScript],
//         option: '''
//         {
//           title : {
//               text: 'Points Collected (Malaysia)',
//               x:'left',
//               y:'top',
//           },
//           toolbox: {
//               show : true,
//               orient : 'vertical',
//               x: 'right',
//               feature : {
//                 restore : {show: true},
//                 mark : {show: true},
//               }
//           },
//           dataRange: {
//               min: 0,
//               max: 1000000,
//               text:['High','Low'],
//               realtime: false,
//               calculable : true,
//               color: ['#ED6F61','#faa700','#327589','#75FAD7']
//           },
//           series : [
//               {
//                 name: 'Points Collected (Malaysia)',
//                 type: 'map',
//                 mapType: 'world',
//                 roam: true,
//                 itemStyle:{
//                   emphasis:{label:{show:true}}
//                 },
//                 data:[
//                     {name : 'Johor', value : 28397},
//                     {name : 'Kedah', value : 19549},
//                     {name : 'Kelantan', value : 3150},
//                     {name : 'Kuala Lumpur', value : 13076},
//                     {name : 'Labuan', value : 3150},
//                     {name : 'Melaka', value : 3150},
//                     {name : 'Negeri Sembilan', value : 3150},
//                     {name : 'Pahang', value : 3150},
//                     {name : 'Perak', value : 3150},
//                     {name : 'Perlis', value : 3150},
//                     {name : 'Pulau Pinang', value : 3150},
//                     {name : 'Putrajaya', value : 3150},
//                     {name : 'Sabah', value : 3150},
//                     {name : 'Sarawak', value : 3150},
//                     {name : 'Selangor', value : 700000},
//                     {name : 'Terrengganu', value : 3150},
//                 ]
//               }
//           ]
//       }
//       ''',
//       ),
//     );
