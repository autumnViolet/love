var LunarDaysOfMonth = new Array
        (
            0xd4a8, 0xd4a0, 0xda50, 0x5aa8, 0x56a0, 0xaad8, 0x25d0, 0x92d0, 0xc958, 0xa950, // 2001-2010
            0xb4a0, 0xb550, 0xb550, 0x55a8, 0x4ba0, 0xa5b0, 0x52b8, 0x52b0, 0xa930, 0x74a8, // 2011-2020
            0x6aa0, 0xad50, 0x4da8, 0x4b60, 0x9570, 0xa4e0, 0xd260, 0xe930, 0xd530, 0x5aa0, // 2021-2030
            0x6b50, 0x96d0, 0x4ae8, 0x4ad0, 0xa4d0, 0xd258, 0xd250, 0xd520, 0xdaa0, 0xb5a0, // 2031-2040
            0x56d0, 0x4ad8, 0x49b0, 0xa4b8, 0xa4b0, 0xaa50, 0xb528, 0x6d20, 0xada0, 0x55b0  // 2041-2050
            );

// 数组LunarLeapYear存放农历2001年到2050年闰月的月份，如没有则为0，从高到低，每字节存两年
var LunarLeapYear = new Array
        (
            0x40, 0x02, 0x07, 0x00, 0x50, // 2001-2010
            0x04, 0x09, 0x00, 0x60, 0x04, // 2011-2020
            0x00, 0x20, 0x60, 0x05, 0x00, // 2021-2030
            0x30, 0xb0, 0x06, 0x00, 0x50, // 2031-2040
            0x02, 0x07, 0x00, 0x50, 0x03  // 2041-2050
            );


// 返回农历iLunarYear年的闰月月份，如没有则返回0
function GetLeapMonth(iLunarYear)
{
    var Leap = LunarLeapYear[(iLunarYear - 2001) >> 1];
    return (((iLunarYear - 2001) & 1) == 0) ? (Leap >> 4) : (Leap & 0x0f);
}

// 返回农历iLunarYer年iLunarMonth月的天数，结果是一个长整数
// 如果iLunarMonth不是闰月， 高字为0，低字为该月的天数
// 如果iLunarMonth是闰月， 高字为后一个月的天数，低字为前一个月的天数
function LunarMonthDays(iLunarYear, iLunarMonth)
{
    var High;
    var Low;
    var Bit;

    High = 0;
    Low = 29;
    Bit = 16 - iLunarMonth;
    if ((iLunarMonth > GetLeapMonth(iLunarYear)) && (GetLeapMonth(iLunarYear) > 0))  Bit--;
    if ((LunarDaysOfMonth[iLunarYear - 2001] & (1 << Bit)) > 0)  Low++;
    if (iLunarMonth == GetLeapMonth(iLunarYear))
    {
        High = ((LunarDaysOfMonth[iLunarYear - 2001] & (1 << (Bit-1))) > 0) ?  30 : 29;

    }

    return Low + (High << 16);
}

// 返回农历iLunarYear年的总天数
function LunarYearDays(iLunarYear)
{
    var Days;
    var tmp;

    Days = 0;
    for (var i=1; i <= 12; i++)
    {
        tmp = LunarMonthDays(iLunarYear, i);
        Days = Days + ((tmp >> 16) & 0xffff); //取高位
        Days = Days + (tmp & 0xffff); //取低位
    }

    return Days;
}

// 将农历iLunarYear年格式化成天干地支记年法表示的字符串
function FormatLunarYear(iLunarYear)
{
    var szText1 = new String("甲乙丙丁戊己庚辛壬癸");
    var szText2 = new String("子丑寅卯辰巳午未申酉戌亥");
    var strYear;

    strYear = szText1.substr((iLunarYear - 4) % 10, 1);
    strYear = strYear + szText2.substr((iLunarYear - 4) % 12, 1);


    return strYear + "年";
}

// 将农历iLunarMonth月格式化成农历表示的字符串
function FormatLunarMonth(iLunarMonth)
{
    var szText = new String("正二三四五六七八九十冬腊");
    var strMonth;

    //    if (iLunarMonth <= 10)
    //    {
    strMonth = szText.substr(iLunarMonth - 1, 1);
    //    }
    //    else if (iLunarMonth == 11) strMonth = "冬";
    //    else strMonth = "腊";

    return strMonth + "月";
}

// 将农历iLunarDay日格式化成农历表示的字符串
function FormatLunarDay(iLunarDay)
{
    var szText1 = new String("初十廿三");
    var szText2 = new String("一二三四五六七八九十");
    var strDay;
    if ((iLunarDay != 20) && (iLunarDay != 30))
    {
        strDay = szText1.substr((iLunarDay - 1) / 10, 1) + szText2.substr((iLunarDay - 1) % 10, 1);
    }
    else if (iLunarDay != 20)
    {
        strDay = szText1.substr(iLunarDay / 10, 1) + "十";
    }
    else
    {
        strDay = "二十";
    }

    return strDay;
}

// 将公历日期转换为农历日期，返回农历表示的字符串
function GetLunarDateString(SolarDate)
{
    var tmp;
    var iLunarYear;
    var iLunarMonth;
    var iLunarDay;
    var Leap = false;
    var MinMilli = 1000 * 60;
    var HrMilli = MinMilli * 60;
    var DyMilli = HrMilli * 24;

    // 从2001年1月1日算起，给定的公历日期已经过去的天数
    // 11323是1970年1月1日到2001年1月1日之间的天数，因为Date是从1970年1月1日作为起点的
    var iSpanDays = Math.round(SolarDate.getTime() / DyMilli) - 11323;

    // 公历2001年1月24日为农历2001年正月初一，差23天
    if (iSpanDays < 23)
    {
        iLunarYear = 2000;
        iLunarMonth = 12;
        iLunarDay = iSpanDays + 7;
    }
    else
    {
        // 从农历2001年正月初一算起
        iSpanDays = iSpanDays - 23;
        iLunarYear = 2001;
        iLunarMonth = 1;
        iLunarDay = 1;

        // 计算农历年
        tmp = LunarYearDays(iLunarYear);
        while (iSpanDays >= tmp)
        {
            iSpanDays -= tmp;
            iLunarYear++;
            tmp = LunarYearDays(iLunarYear);
        }

        // 计算农历月
        tmp = LunarMonthDays(iLunarYear, iLunarMonth) & 0xffff; //取低字
        while (iSpanDays >= tmp)
        {
            iSpanDays -= tmp;
            if (iLunarMonth == GetLeapMonth(iLunarYear))  // 该年该月闰月
            {
                tmp = LunarMonthDays(iLunarYear, iLunarMonth) >> 16; //取高字
                if (iSpanDays < tmp)
                {
                    Leap = (tmp > 0) ? true : false;  // 闰月的后个月？
                    break;
                }
                iSpanDays = iSpanDays - tmp;
            }

            iLunarMonth++;
            tmp = LunarMonthDays(iLunarYear,iLunarMonth) & 0xffff; //取低字
        }

        // 计算农历日
        iLunarDay += iSpanDays;
    }

    return FormatLunarYear(iLunarYear) + (Leap ? "闰" : "") + FormatLunarMonth(iLunarMonth) + FormatLunarDay(iLunarDay);
}
function getLen( str) {
    var totallength=0;
    for (var i=0;i<str.length;i++)
    {
        //charCodeAt 返回一个整数，获得字符的unicode编码
        var intCode=str.charCodeAt(i);
        if (intCode>=0&&intCode<=128) {//为字符的编码范围
            totallength=totallength+1;//非中文单个字符长度加1
        }
        else {
            totallength=totallength+2;//中文字符长度则加2
        }
    }
    return totallength;
}
function judgesolarfestival(solardate){
    var sTermInfo = new Array(0,21208,42467,63836,85337,107014,128867,150921,173149,195551,218072,240693,263343,285989,308563,331033,353350,375494,397447,419210,440795,462224,483532,504758);
    var solarTerm = new Array("小寒","大寒","立春","雨水","惊蛰","春分","清明","谷雨","立夏","小满","芒种","夏至","小暑","大暑","立秋","处暑","白露","秋分","寒露","霜降","立冬","小雪","大雪","冬至");
    var lFtv = new Array("0101 春节","0115 元宵节","0505 端午节","0707 七夕情人节","0715 中元节","0815 中秋节","0909 重阳节","1208 腊八节","1224 小年");
    var sFtv = new Array("0101 元旦","0112 香水节","0214 情人节","0308 妇女节","0312 植树节","0315 消费者权益日","0401 愚人节","0501 劳动节","0504 青年节","0601 儿童节","0701 建党节",
                         "0801 建军节","0910 教师节","1001 国庆节",
                         "1006 老人节","1024 联合国日","1224 平安夜","1225 圣诞节")
    var tmp1 = new Date((31556925974.7*(solardate.getFullYear()-1900)+sTermInfo[solardate.getMonth()*2+1]*60000)+Date.UTC(1900,0,6,2,5))
    var tmp2 = tmp1.getUTCDate()
    var festivalstring = "";

    if (tmp2==solardate.getDate()) festivalstring = solarTerm[solardate.getMonth()*2+1];
    tmp1 = new Date((31556925974.7*(solardate.getFullYear()-1900)+sTermInfo[solardate.getMonth()*2]*60000)+Date.UTC(1900,0,6,2,5));
    tmp2= tmp1.getUTCDate();
    if (tmp2==solardate.getDate()) festivalstring = solarTerm[solardate.getMonth()*2];
    for(var i in lFtv){

        if(lFtv[i].match(/^(\d{2})(.{2})([\s\*])(.+)$/)) {
            tmp1=Number(RegExp.$1)-getLunarMonth(GetLunarDateString(solardate))-1;
            tmp2=Number(RegExp.$2)-getLunarDate(GetLunarDateString(solardate));
            if(tmp1==0 && tmp2==0) festivalstring=RegExp.$4;
        }
    }

    for(var j in sFtv){
        if(sFtv[j].match(/^(\d{2})(\d{2})([\s\*])(.+)$/)){
            tmp1 = Number(RegExp.$1)-(solardate.getMonth()+1);
            tmp2 = Number(RegExp.$2)-solardate.getDate();
            if(tmp1 ==0 && tmp2 == 0)
                festivalstring = RegExp.$4;
        }
    }
    return festivalstring;
}
function getLunarMonth(lunarformatstring){
    var szText = new String("正二三四五六七八九十冬腊");
    var lunarmonth = lunarformatstring.substr(getLen(lunarformatstring)/2-4,1);
    for(var i=0; i<12; i++){
        if(lunarmonth == szText.substr(i,1)){
            return i;
        }
    }
}
function getLunarDate(lunarformatstring){
    var szText1 = new String("初十廿三");
    var szText2 = new String("一二三四五六七八九");
    var lunardate = lunarformatstring.substr(getLen(lunarformatstring)/2-2,2);
    var tens=0, unit=0;
    for(var i=0; i<4; i++){
        if(lunardate.substr(0,1) == szText1.substr(i, 1)){
            tens = i;
        }
    }
    if(lunardate.substr(1,1) == "十")
        unit = 0;
    for(var j=0; j<10; j++){
        if(lunardate.substr(1,1) == szText2.substr(j, 1)){
            unit = j+1;
        }
    }
    return (tens*10+unit);
}

