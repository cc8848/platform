define("module/UserInfo",["lib/jquery","util/artTemplate","module/Dialog","module/Validator","util/ajaxPromise"],function(e){"use strict";var l,a,o,t,i,s,n,r,c,d,m,u,v,f,p;return l=e("lib/jquery"),a=e("util/artTemplate"),t=e("module/Dialog"),i=e("module/Validator"),s=e("util/ajaxPromise"),r=function(e){return s({url:window.basePath+"user/getTikuTeamList",type:"GET",dataType:"json",data:{role:e}}).then(function(e){var l;return l=e.result,l.unshift({id:"",name:"请选择"}),l})},c=function(e){return s({url:window.basePath+"role/getRoleList",data:{filter:e},type:"GET",dataType:"json"}).then(function(l){var a;return a=l.result,a.unshift({id:"",name:1===e?"教师/学生":"请选择"}),a})},f=a.compile(["{{each options}}",'<option value="{{$value.id}}">{{$value.name}}</option>',"{{/each}}"].join("")),p=a.compile(["{{each info}}",'<option {{if id===$value.id+""}}selected="selected"{{/if}} value="{{$value.id}}">{{$value.name}}</option>',"{{/each}}"].join("")),d=a.compile(['<div class="form-horizontal">','<div class="form-group">','<label class="col-sm-4 control-label">手机号：</label>','<div class="col-sm-8">','<input type="text" value="{{userMobile}}" class="user-mobile form-control" maxLength="30"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">密码：</label>','<div class="col-sm-8">','<input type="text" value="" class="password form-control"  maxLength="30"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">账号：</label>','<div class="col-sm-8">','<input type="text" value="{{userKey}}" class="user-key form-control" disabled/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">姓名：</label>','<div class="col-sm-8">','<input type="text" value="{{userName}}" class="user-name form-control"  maxLength="30"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">身份：</label>','<div class="col-sm-8">','<select class="identity form-control" {{if teamRole!=="学生组员" && teamRole!=="教师组员"}}disabled="disabled"{{/if}}>','<option {{if identity===""}}selected="selected"{{/if}} value="">请选择</option>','<option {{if identity==="教师"}}selected="selected"{{/if}} value="教师">教师</option>','<option {{if identity==="学生"}}selected="selected"{{/if}} value="学生">学生</option>',"</select>","</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">小组：</label>','<div class="col-sm-8">','<select class="team form-control" {{if teamRole!=="学生组员" && teamRole!=="教师组员"}}disabled="disabled"{{/if}}>',"{{each teamInfo}}",'<option {{if teamId===$value.id}}selected="selected"{{/if}} value="{{$value.id}}">{{$value.name}}</option>',"{{/each}}","</select>","</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">状态：</label>','<div class="col-sm-8">','<select class="status form-control">','<option {{if status===0}}selected="selected"{{/if}} value="0">启用</option>','<option {{if status===1}}selected="selected"{{/if}} value="1">禁用</option>',"</select>","</div>","</div>","</div>"].join("")),m=a.compile(['<div class="form-horizontal">','<div class="form-group">','<label class="col-sm-4 control-label">手机号：</label>','<div class="col-sm-8">','<input type="text" value="{{userMobile}}" class="user-mobile form-control" maxLength="30"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">密码：</label>','<div class="col-sm-8">','<input type="text" value="" class="password form-control"  maxLength="30"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">账号：</label>','<div class="col-sm-8">','<input type="text" value="{{userKey}}" class="user-key form-control" disabled/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">姓名：</label>','<div class="col-sm-8">','<input type="text" value="{{userName}}" class="user-name form-control"  maxLength="30"/>',"</div>","</div>","</div>"].join("")),u=a.compile(['<div class="form-horizontal">','<div class="form-group">','<label class="col-sm-4 control-label">小组：</label>','<div class="col-sm-8">','<input class="team-name form-control" type="text" value="{{teamName}}">',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">原组长：</label>','<div class="col-sm-8">','<span class="captain form-control">{{captainName}}</span>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">新组长：</label>','<div class="col-sm-8">','<select class="captain form-control">',"{{each teamInfo}}",'<option value="{{$value.key}}">{{$value.name||$value.key}}</option>',"{{/each}}","</select>","</div>","</div>","</div>"].join("")),v=a.compile(['<div class="form-horizontal">','<div class="form-group">','<label class="col-sm-4 control-label">小组：</label>','<div class="col-sm-8">','<input class="team-name form-control" type="text" value="{{teamName}}">',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">组长：</label>','<div class="col-sm-8">','<select class="captain form-control">',"{{each teamInfo}}",'<option value="{{$value.key}}">{{$value.name||$value.key}}</option>',"{{/each}}","</select>","</div>","</div>","</div>"].join("")),o=new t("modal-dialog"),n={initTeam:function(e,a){"string"===l.type(e)&&(e=l("#"+e)),r("").then(function(l){e.append(p({info:l,id:a}))})},initRole:function(e,a){"string"===l.type(e)&&(e=l("#"+e)),c(0).then(function(l){e.append(p({info:l,id:a}))})},addMember:function(e){Promise.all([r("学生"),c(1)]).then(function(a){o.show({sizeClass:"modal-sm",title:"创建用户",content:['<div class="form-horizontal">','<div class="form-group">','<label class="col-sm-4 control-label">手机号：</label>','<div class="col-sm-8">','<input type="text" value="" class="user-mobile form-control" maxLength="30"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">密码：</label>','<div class="col-sm-8">','<input type="text" value="" class="password form-control"  maxLength="30"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">账号：</label>','<div class="col-sm-8">','<input type="text" value="" class="user-key form-control"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">姓名：</label>','<div class="col-sm-8">','<input type="text" value="" class="user-name form-control" maxLength="30"/>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">角色：</label>','<div class="col-sm-8">','<select class="role form-control"></select>',"</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">身份：</label>','<div class="col-sm-8">','<select class="identity form-control">','<option value="">请选择</option>','<option value="教师">教师</option>','<option selected="selected" value="学生">学生</option>',"</select>","</div>","</div>",'<div class="form-group">','<label class="col-sm-4 control-label">小组：</label>','<div class="col-sm-8">','<select class="team form-control"></select>',"</div>","</div>","</div>"].join(""),source:e,initial:function(){var e,l=this;e=l._container,e.find("input").val(""),e.find(".identity").val("学生"),e.find(".team").html(f({options:a[0]})),e.find(".role").html(f({options:a[1]}))},renderCall:function(){var e,a,o=this;e=o._container.find(".team"),a=o._container.find(".identity"),o._container.find(".identity").on("change",function(a){var o=l(this).val();r(o).then(function(l){e.html(f({options:l}))})}),o._container.find(".role").on("change",function(o){var t=l(this).val(),i=""!==t;e.prop("disabled",i),a.prop("disabled",i)})},confirm:function(){var e,l,a,o,t=this,n=new i,r={};return e=t._container,l=e.find(".user-mobile"),r.userMobile=l.val().trim(),a=e.find(".user-key"),r.userKey=a.val().trim(),o=e.find(".password"),r.password=o.val(),n.add(r.userMobile,"mobileFormat",function(){alert("手机号码不正确"),l.val("").focus()}).add(r.userKey,"isNotEmpty",function(){alert("账号不能为空"),a.val("").focus()}).add(r.password,"isNotEmpty",function(){alert("密码不能为空"),o.val("").focus()}),n.start()?(r.groupName=e.find(".role").val(),""===r.groupName&&(r.role=e.find(".identity").val(),r.groupName=r.role+"组员",r.teamId=e.find(".team").val()),r.userName=e.find(".user-name").val().trim(),void s({url:window.basePath+"user/addUserInfo",type:"GET",data:r,dataType:"json"}).then(function(e){window.location.reload()},function(){t.enableConfirm()})):void t.enableConfirm()}})})},editMember:function(e){r(e.identity).then(function(a){e.teamInfo=a,o.show({sizeClass:"modal-sm",title:"编辑用户",content:d(e),force:1,renderCall:function(){var e=this;e._container.find(".identity").on("change",function(a){var o=l(this).find("option:selected").val();r(o,function(l){e._container.find(".team").html(f({options:l}))})})},confirm:function(){var a,o=this,t=new i,n={};return a=o._container,n.userMobile=a.find(".user-mobile").val().trim(),t.add(n.userMobile,"mobileFormat",function(){alert("手机号码不正确")}),t.start()?(l.extend(n,{userKey:e.userKey,id:e.userId,userName:a.find(".user-name").val().trim(),password:a.find(".password").val(),status:a.find(".status").val(),teamId:a.find(".team").val(),groupName:e.role}),"学生组员"!==e.role&&"学生组组长"!==e.role&&"教师组员"!==e.role&&"教师组组长"!==e.role?n.role="":n.role=a.find(".identity").val(),void s({url:window.basePath+"user/updateUserInfo",type:"GET",data:n,dataType:"json"}).then(function(e){window.location.reload()},function(){o.enableConfirm()})):void o.enableConfirm()}})})},addMemberIncomplete:function(e){o.show({sizeClass:"modal-sm",title:"创建用户",content:m({userMobile:"",userKey:"",userName:""}),source:e,initial:function(){var e=this,l=e._container;l.find("input").val("")},confirm:function(){var e,l,a,o=this,t=new i;return e=o._container,l=e.find(".user-mobile").val().trim(),t.add(l,"mobileFormat",function(){alert("手机号码不正确")}),t.start()?(a=e.find(".role").val(),void s({url:window.basePath+"user/addUserInfo",type:"GET",data:{userKey:e.find(".user-key").val().trim(),userName:e.find(".user-name").val().trim(),userMobile:l,password:e.find(".password").val(),status:0},dataType:"json"}).then(function(e){window.location.reload()},function(){o.enableConfirm()})):void o.enableConfirm()}})},editMemberIncomplete:function(e){o.show({sizeClass:"modal-sm",title:"编辑用户",content:m(e),force:1,confirm:function(){var l,a,o=this,t=new i;return l=o._container,a=l.find(".user-mobile").val().trim(),t.add(a,"mobileFormat",function(){alert("手机号码不正确")}),t.start()?void s({url:window.basePath+"user/updateUserInfo",type:"GET",data:{id:e.userId,userKey:e.userKey,userName:l.find(".user-name").val().trim(),userMobile:a,password:l.find(".password").val(),status:0},dataType:"json"}).then(function(e){window.location.reload()},function(){o.enableConfirm()}):void o.enableConfirm()}})},addTeam:function(e){s({url:window.basePath+"user/getCanCaptainUsersList",type:"GET",dataType:"json"}).then(function(l){return 0===l.result.length?void alert("暂时没有可以任命的组长"):void o.show({sizeClass:"modal-sm",title:"创建小组",content:v({teamInfo:l.result}),initial:function(){var e=this;e._container.find(".team-name").val("")},source:e,confirm:function(){var e,l,a=this;e=a._container,l=e.find(".captain :selected"),s({url:window.basePath+"tranops/newTeam",type:"GET",data:{teamName:e.find(".team-name").val(),captain:l.val(),captainName:l.text()},dataType:"json"}).then(function(e){window.location.reload()},function(){a.enableConfirm()})}})})},editTeam:function(e){s({url:window.basePath+"user/getUsersListByTeamId",type:"GET",data:{teamId:e.teamId},dataType:"json"}).then(function(l){var a;a=l.result,e.teamInfo=a,o.show({sizeClass:"modal-sm",title:"编辑小组",content:u(e),force:1,confirm:function(){var l,a=this;l=a._container,s({url:window.basePath+"tranops/updateTeam",type:"GET",data:{teamId:e.teamId,oldCaptain:e.captain,newCaptain:l.find(".new-captain").val(),newTeamName:l.find(".team-name").val()},dataType:"json"}).then(function(e){window.location.reload()},function(){a.enableConfirm()})}})})}}});