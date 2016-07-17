express = require('express')
router = express.Router(mergeParams: true)
db = require('../database')
Errors = require('../errors')

router.get('/bulletin', (req, res)->
  Richtext = db.models.richtext
  Richtext.find(
    where:
      name : "bulletin"
  )
  .then (bulletin)->
    return bulletin if bulletin
    Richtext.create(
      name: "bulletin"
      content : "<strong>“健康中国2020”</strong>：改善城乡居民健康状况，提高国民健康生活质量，减少不同地区健康状况差异，主要健康指标基本达到中等发达国家水平。<br>&nbsp;&nbsp;&nbsp;&nbsp;到2015年，基本医疗卫生制度初步建立，使全体国民人人拥有基本医疗保障、人人享有基本公共卫生服务，医疗卫生服务可及性明显增强，地区间人群健康状况和资源配置差异明显缩小，国民健康水平居于发展中国家前列。<br>&nbsp;&nbsp;&nbsp;&nbsp;到2020年，完善覆盖城乡居民的基本医疗卫生制度，实现人人享有基本医疗卫生服务，医疗保障水平不断提高，卫生服务利用明显改善，地区间人群健康差异进一步缩小，国民健康水平达到中等发达国家水平。"
    )
  .then (bulletin)->
    bulletin = bulletin.get(plain:true)
    res.json(bulletin)
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)
)

.get('/about', (req, res)->
  Richtext = db.models.richtext
  Richtext.find(
    where:
      name : "about"
  )
  .then (about)->
    return about if about
    Richtext.create(
      name: "about"
      content : "<p>
        &nbsp;&nbsp;&nbsp;&nbsp;中国西部研究与发展促进会健康中国推进工作委员会，是中国西部研究与发展促进会的直属机构。<br>
        &nbsp;&nbsp;&nbsp;&nbsp;委员会以党的科学发展观为指导，促进我国西部地区健康中国战略推进工作有序发展为目标，认真做好改善西部地区医疗卫生条件、促进人才与信息交流、为有需要的地区提供医疗卫生帮扶工作。为政府主管部门和医疗卫生领域的科研机构、生产企业、设计、检测机构、大专院校、学术团体提供服务；协调政府机构或组织与企业之间、医疗卫生科研机构与企业之间、企业与企业之间、医疗卫生产品与用户之间的关系，发挥桥梁与纽带作用，促进我国医疗公共卫生事业的健康发展。<br>
        &nbsp;&nbsp;&nbsp;&nbsp;委员会办公地点设在北京。<br>
        </p>"
    )
  .then (about)->
    about = about.get(plain:true)
    res.json(about)
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)
)

module.exports = router