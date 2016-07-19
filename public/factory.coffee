angular.module('west-dbms', [
])
.factory 'DBMS', ($http)->
  user = {
    id: undefined 
    username : undefined
    nickname : undefined
    refresh: ()->
      $http.get("/users")
      .then (res)->
        user.id = res.data.id
        user.username = res.data.username
        user.nickname = res.data.nickname
      .catch (err)->
        console.log err
  }

  news = {
    data: []
    dic: {}
    refresh: ()->
      $http.get("/news")
      .then (res)->
        news.data.splice(0, news.data.length)
        for _news,i in res.data
          _news.index = i
          news.data.push(_news)
          news.dic[_news.id] = _news
      .catch (err)->
        console.log err
        alert(err.data.message)
    push: (_news)->
      $http.post("/news", _news)
      .then (res)->
#        news.push(res.data)
#        news.data.push(_news)
#        news.dic[_news.id] = _news
        alert("Published successfully")
        news.refresh()
        return res.data

    update: (_news)->
      $http.post("/news/#{_news.id}", _news)
      .then (res)->
#        return if not news.dic[_news.id]?.index
#        _news.index =news.dic[_news.id].index
#        news.data[_news.index] = _news
#        news.dic[_news.id] = _news
        alert("Updated successfully")
        news.refresh()
        return res.data

    delete: (_news)->
      $http.delete("/news/#{_news.id}")
      .then (res)->
        alert("Deleted successfully")
        news.refresh()
  }
  slides = [
    image: "images/news/img1.jpg"
    url: 'http://www.chinawestern.org/newsread.asp?NewsID=6272'
    text: "医疗扶贫项目正式签约"
    index : 0
  ,
    image: "images/news/img2.jpg"
    url: 'http://www.chinawestern.org/newsread.asp?NewsID=6269'
    text: "中国西部发展促进会慰问驻云南边防官兵"
    index : 1
  ]

  richtext = {
    about : {
      name : "about"
      content : ""
    }
    notify : {
      name : "notify"
      content : ""
    }
    contact : {
      name : "contact"
      content : ""
    }
    expert : {
      name : "expert"
      content : ""
    }
    _refresh: (name)->
      $http.get("/richtext", params:
        key: name)
      .then (res)->
        richtext[name].content = res.data.content
      .catch (err)->
        console.log err
    refresh : ()->
      richtext._refresh("about")
      richtext._refresh("notify")
      richtext._refresh("contact")
      richtext._refresh("expert")

    update : (rt)->
      $http.post("/richtext", rt)
      .then (res)->
        rt = res.data
        richtext[rt.name].content = rt.content
      .catch (err)->
        console.log err
  }

  about = content: "<p>
  &nbsp;&nbsp;&nbsp;&nbsp;中国西部研究与发展促进会健康中国推进工作委员会，是中国西部研究与发展促进会的直属机构。<br>
  &nbsp;&nbsp;&nbsp;&nbsp;委员会以党的科学发展观为指导，促进我国西部地区健康中国战略推进工作有序发展为目标，认真做好改善西部地区医疗卫生条件、促进人才与信息交流、为有需要的地区提供医疗卫生帮扶工作。为政府主管部门和医疗卫生领域的科研机构、生产企业、设计、检测机构、大专院校、学术团体提供服务；协调政府机构或组织与企业之间、医疗卫生科研机构与企业之间、企业与企业之间、医疗卫生产品与用户之间的关系，发挥桥梁与纽带作用，促进我国医疗公共卫生事业的健康发展。<br>
  &nbsp;&nbsp;&nbsp;&nbsp;委员会办公地点设在北京。<br>
  </p>"

  notify = "<strong>“健康中国2020”</strong>：改善城乡居民健康状况，提高国民健康生活质量，减少不同地区健康状况差异，主要健康指标基本达到中等发达国家水平。<br>&nbsp;&nbsp;&nbsp;&nbsp;到2015年，基本医疗卫生制度初步建立，使全体国民人人拥有基本医疗保障、人人享有基本公共卫生服务，医疗卫生服务可及性明显增强，地区间人群健康状况和资源配置差异明显缩小，国民健康水平居于发展中国家前列。<br>&nbsp;&nbsp;&nbsp;&nbsp;到2020年，完善覆盖城乡居民的基本医疗卫生制度，实现人人享有基本医疗卫生服务，医疗保障水平不断提高，卫生服务利用明显改善，地区间人群健康差异进一步缩小，国民健康水平达到中等发达国家水平。"

  contact = '''
  <p>健康中国推进工作委员会</p>

  <p>地址：北京市西城区永安路106号</p>

  <p>邮编：100050</p>

  <p>电话号码：010-83167988</p>

  <p>传真号码：010-83151568</p>

  <p>电子邮箱：<a href="mailto:44228557@qq.com">44228557@qq.com</a></p>

  <p style="text-align:right">&nbsp;</p>
  '''

  policy_list = [
    title: '工作条例'
    content: '''
    <h1 style="text-align: center;">&nbsp;&nbsp;&nbsp; 中国西部研究与发展促进会健康中国推进工作委员会&nbsp;&nbsp;</h1>

    <h2 style="text-align: center;">工作条例</h2>

    <p>&nbsp;</p>

    <p style="text-align: center;"><strong>第一章</strong><strong>&nbsp; 总则</strong></p>

    <p><br />
    <strong>第一条&nbsp; 中国西部研究与发展促进会健康中国推进工作委员会（以下简称：委员会），是中国西部研究与发展促进会的直属机构；</strong></p>

    <p><br />
    <strong>第二条&nbsp; 委员会的宗旨：以党的科学发展观为指导，促进我国西部地区健康中国战略推进工作有序发展为目标，认真做好改善西部地区医疗卫生条件、促进人才与信息交流、为有需要的地区提供医疗卫生帮扶工作。</strong></p>

    <p>&nbsp;</p>

    <p><strong>第三条 为政府主管部门和医疗卫生领域的科研机构、生产企业、设计、检测机构、大专院校、学术团体提供服务；</strong></p>

    <p>&nbsp;</p>

    <p><strong>第四条&nbsp; 协调政府机构或组织与企业之间、医疗卫生科研机构与企业之间、企业与企业之间、医疗卫生产品与用户之间的关系，发挥桥梁与纽带作用，促进我国医疗公共卫生事业的健康发展。</strong></p>

    <p>&nbsp;</p>

    <p><strong>第五条</strong><strong>&nbsp; 委员会办公地点设在北京。</strong></p>

    <p style="text-align: center;"><strong>第二章&nbsp; 工作任务</strong></p>

    <p><br />
    <strong>第六条&nbsp; 认真贯彻党的十八届五中全会精神及国家经济转型的方针和政策，宣传国家关于医疗卫生的政策、法规；</strong></p>

    <p><br />
    <strong>（1）根据医疗卫生领域经济发展趋势和科技科研成果应用的市场状态，参与医疗卫生行业标准的考察调研并编写调研报告、制定工作，为政府在医疗卫生领域的决策提供科学依据。</strong></p>

    <p><strong>（</strong><strong>2）推广优秀的医疗卫生科研成果和先进的技术、促进医疗卫生科研成果和先进技术的应用，为医疗卫生经济发展服务。</strong></p>

    <p><strong>三</strong><strong>&nbsp; 编辑出版医疗卫生科技创新和新产品的应用等相关资料和书刊，普及医疗卫生科学知识和宣传国内外医疗卫生事业发展和科技成果应用的时实消息。</strong></p>

    <p><br />
    <strong>四&nbsp; 组织医疗卫生领域的科研机构和生产企业开展科研技术、医疗卫生产品、企业管理等信息交流、展览、咨询、培训等服务活动。建立企业间经济协作关系，提高医疗卫生企业经济效益和社会效益；</strong></p>

    <p><br />
    <strong>五&nbsp; 依法协助相关企业维护自身的合法权益，反映企业呼声，规范企业行为，协调行业关系，促进医疗卫生领域企业的经济发展。</strong></p>

    <p><br />
    <strong>六&nbsp; 收集、整理医疗卫生科研成果应用数据情报，总结相关科研机构、生产企业、使用单位合作应用医疗卫生科研成果的成功经验，进行市场调研，创建医疗卫生经济发展与科研成果数据库，服务于医疗卫生领域。</strong></p>

    <p><br />
    <strong>七&nbsp; 建立和加强同国内外医疗卫生领域的科研机构、学术团体的联系和学术交流，组织医疗卫生领域的专家为科研机构、生产企业服务，参加国内外相关科研技术交流活动。</strong></p>

    <p><strong>八&nbsp; 为医疗卫生产业提供宣传/报道/广告的渠道和平台.</strong></p>

    <p style="text-align: center;"><strong>第三章&nbsp; 委员会服务主要对象</strong></p>

    <p><br />
    <strong>第七条&nbsp; 委员会服务的主要对象是委员会发展的中国西促会会员单位和理事单位；会员和理事单位须是从事医疗卫生领域的科研设计、生产、应用、检测的企事业单位、大专院校、学术团体经委员会初审后，报中国西促会审核批准成为中国西促会会员单位。医疗卫生领域的科研工程技术人员、专家学者，热心医疗卫生领域的志愿者经委员会初审后，报中国西促会审核批准后成为中国西促会会员，均为委员会的优先服务对象。<br />
    第八条&nbsp; 委员会发展的会员权利和义务：<br />
    &nbsp; &nbsp; （委员会发展的）会员依据本条例享有下列权利：<br />
    &nbsp;&nbsp;&nbsp; （1）依据中国西促会章程享有中国西促会会员应当享有的权力以外，优先享有委员会服务的权力。<br />
    &nbsp;&nbsp;&nbsp; （2）对委员会工作的批评建议权和监督权；<br />
    &nbsp;&nbsp;&nbsp; （3）通过委员会和中国西促会向政府有关部门就医疗卫生领域的科研和经济发展提出建议和意见。</strong></p>

    <p><br />
    <strong>第九条&nbsp; 委员会发展的会员应履行下列义务：</strong></p>

    <p><strong>（1）遵守中国西促会的章程执行中国西促会的决议，积极参加健康中国推进工作委员会组织的活动并尽力提供方便和资助；</strong></p>

    <p><strong>（2）维护中国西促会和健康中国推进工作委员会的声誉和合法利益；</strong></p>

    <p><strong>（</strong><strong>3）及时向委员会反映并提供企业管理信息、企业管理调查报告，产品市场分析、科技研究成果、统计数据及其他资料；</strong></p>

    <p><strong>（4）委员会发展的会员按规定交纳会费。<br />
    &nbsp;&nbsp;&nbsp; </strong></p>

    <p><strong>第十条&nbsp; 委员会发展的会员退会应书面通知委员会，由委员会报中国西促会秘书处备案。<br />
    &nbsp;&nbsp;&nbsp; </strong></p>

    <p><strong>第十一条&nbsp; 委员会发展的会员连续2年不缴纳会费，不参加委员会组织活动的视为自动退会，并在中国西促会网站及相关媒体发布公告。<br />
    &nbsp;&nbsp;&nbsp; </strong></p>

    <p><strong>第十二条&nbsp; 委员会发展的会员严重违反中国西促会章程的行为依照中国西促会章程处理。</strong></p>

    <p><strong>&nbsp;&nbsp;&nbsp; </strong></p>

    <p><strong>第十三条&nbsp; 公章的使用管理：公章的刻制及管理由西促会办公室统一管理。</strong></p>

    <p style="text-align: center;"><strong>第四章</strong><strong>&nbsp; 组织机构</strong></p>

    <p><br />
    <strong>第十四条&nbsp; 委员会设:顾问（若干人），主任（一人），副主任（若干人），专家团（若干人）。部门设置须报中国西促会办公室审批同意备案后启动。办公室负责日常工作，并设:健康中国推进工作委员会办公室。</strong></p>

    <ul>
      <li><strong>(1)；委员会顾问：张清华、李丁川、黄平、熊云新、宋友</strong></li>
      <li><strong>(2)；委员会主任：何红莲</strong></li>
      <li><strong>(</strong><strong>3)；委员会副主任：熊云新（兼）、宋友（兼）</strong></li>
      <li><strong>(4)；委员会办公室主任：蒙忠吉</strong></li>
      <li><strong>(5) （1）至（4）所指机构的聘任人员按照相关规定报中国西促会审核备案。</strong></li>
    </ul>

    <p style="text-align: center;"><strong>第五章&nbsp; 经费管理、使用原则</strong></p>

    <p><br />
    <strong>第十五条&nbsp; 经费来源<br />
    &nbsp;&nbsp;&nbsp; 一&nbsp; 会费；<br />
    &nbsp;&nbsp;&nbsp; 二&nbsp; 政府有关机构或组织的资助、企、事单位的捐赠；<br />
    &nbsp;&nbsp;&nbsp; 三&nbsp; 利息；<br />
    &nbsp;&nbsp;&nbsp; 四&nbsp; 其它合法收；</strong></p>

    <p><strong>第十六条</strong><strong>&nbsp; 严格执行民政部规定的社团财务管理规定。委员会不设独立财务，财务由中国西促会统一管理。</strong></p>

    <p style="text-align: center;"><strong>第六章&nbsp; 附则</strong></p>

    <p><br />
    <strong>第十七条&nbsp; 本条例经中国西促会审核通过并备案。</strong></p>

    <p>&nbsp;</p>

    <p><strong>第十八条：本条例是中国西部研究与发展促进会健康中国推进工作委员会工作准则和规程，委员会工作人员应严格遵守。</strong></p>

    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>

    <p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 中国西部研究与发展促进会健康中国推进工作委员会</strong></p>

    <p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;二〇一五 年 &nbsp;十二 月 七 日</strong></p>

    <p><br />
    &nbsp;</p>

    <p>&nbsp;</p>

    <p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></p>

    <p style="text-align:right">&nbsp;</p>'''
    created_at: '2016-01-03 23:33'
    updated_at: '2016-01-04 07:11'
  ,
    "title": '组织架构'
    "content": '''
    <h1 style="text-align: center;"><strong>中国西部研究与发展促进会健康中国推进工作委员会</strong></h1>

    <p><strong>组织架构</strong></p>

    <ul>
      <li>委员会顾问：张清华、李丁川、黄平、熊云新、宋友</li>
      <li>委员会主任：何红莲</li>
      <li>委员会副主任：熊云新（兼）、宋友（兼）</li>
      <li>委员会办公室主任：蒙忠吉</li>
    </ul>

    <p style="text-align:right">&nbsp;</p>

    '''
    created_at: '2016-01-03 23:33'
    updated_at: '2016-01-04 07:11'
  ]

  return {
    user : user
    news : news
    slides : slides
    about : about
    notify : notify
    contact : contact
    policy_list : policy_list
    richtext : richtext
  }