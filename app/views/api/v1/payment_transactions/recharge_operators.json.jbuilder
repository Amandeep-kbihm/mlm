json.array! [
                {name: 'AIRTEL', code: 'AT'},
                {name: 'BSNL', code: 'BS'},
                {name: 'BSNL SPECIAL', code: 'BSS'},
                {name: 'IDEA', code: 'IDX'},
                {name: 'JIO', code: 'JO'},
                {name: 'VODAFONE', code: 'VF'},
                {name: 'RELIANCE CDMA', code: 'RL'},
                {name: 'RELIANCE GSM', code: 'RG'},
                {name: 'UNINOR', code: 'UN'},
                {name: 'UNINOR SPECIAL', code: 'UNS'},
                {name: 'MTS', code: 'MS'},
                {name: 'AIRCEL', code: 'AL'},
                {name: 'TATA DOCOMO GSM', code: 'TD'},
                {name: 'TATA DOCOMO GSM SPECIAL', code: 'TDS'},
                {name: 'TATA INDICOM (CDMA)', code: 'TI'},
                {name: 'MTNL DELHI', code: 'MTD'},
                {name: 'MTNL DELHI SPECIAL', code: 'MTDS'},
                {name: 'MTNL MUMBAI', code: 'MTM'},
                {name: 'MTNL MUMBAI SPECIAL', code: 'MTMS'},
                {name: 'VIDEOCON', code: 'VD'},
                {name: 'VIDEOCON SPECIAL', code: 'VDS'},
                {name: 'VIRGIN GSM', code: 'VG'},
                {name: 'VIRGIN GSM SPECIAL', code: 'VGS'},
                {name: 'VIRGIN CDMA', code: 'VC'},
                {name: 'T24', code: 'T24'},
                {name: 'T24 SPECIAL', code: 'T24S'},
                {name: 'TATA WALKY', code: 'TW'},
            ] do |op|
  json.operator op[:name]
  json.code op[:code]
end



























