package com.xmbl.ops.controller.organization;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xmbl.ops.constant.SessionConstant;
import com.xmbl.ops.model.organization.Resources;
import com.xmbl.ops.model.organization.UserLog;
import com.xmbl.ops.service.organization.ResourcesRoleService;
import com.xmbl.ops.service.organization.ResourcesService;
import com.xmbl.ops.service.organization.UserInfoService;
import com.xmbl.ops.service.organization.UserLogService;
import com.xmbl.ops.util.Common;
import com.xmbl.ops.util.TreeObject;
import com.xmbl.ops.util.TreeUtil;

@Controller
@RequestMapping(value = "")
public class IndexController extends AbstractController {
	@Autowired
	protected UserInfoService userInfoService;
	
	@Autowired
	protected ResourcesService resourcesService;
	
	@Autowired
	protected ResourcesRoleService resourcesRoleService;
	@Autowired
	protected UserLogService userLogService;
	
	@RequestMapping(value = "")
	public String index(HttpServletRequest request, ModelMap model) throws Exception {
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		List<TreeObject> ns = new ArrayList<>();
        List<TreeObject> listtree = new ArrayList<TreeObject>();

		// 验证是否登录成功
//		if (subject.isAuthenticated()) {
			String groupName = (String) session
					.getAttribute(SessionConstant.GROUP_NAME);
			List<Resources> mps = resourcesService.getResourcesbyRoleSign(groupName);
			if( mps != null && mps.size()>0){
				List<TreeObject> list = new ArrayList<TreeObject>();
				Map<String, Object> listmap = new HashMap<String, Object>();
				for (Resources resources : mps) {
					TreeObject ts = new TreeObject();
					ts.setId(resources.getId());
					ts.setParentId(resources.getParentid());
					ts.setName( resources.getName());
					ts.setPid(resources.getPid());
					ts.setResKey(resources.getReskey());
					ts.setType(resources.getType());
					ts.setLevel(resources.getLevel());
					ts.setResUrl(resources.getResurl());
					ts.setDescription(resources.getDescription());
					list.add(ts);		
					Common.flushObject(list, listmap);
				}
				TreeUtil treeUtil = new TreeUtil();
				ns = treeUtil.getChildTreeObjects(list, 0);
                for (TreeObject tree : ns){
                    listtree.add(tree);
                    if( tree.getChildren().size() > 0){
                        for(TreeObject treechild : tree.getChildren()){
                            listtree.add(treechild);
                            if(treechild.getChildren().size() > 0)
                            for(TreeObject treechildchild :treechild.getChildren()){
                                listtree.add(treechildchild);
                                if(treechildchild.getChildren().size() > 0){
                                	 for(TreeObject treechildchildchild :treechildchild.getChildren()){
                                         listtree.add(treechildchildchild);
                                         treechildchildchild.setChildren(null);
                                     }  
                                }
                                treechildchild.setChildren(null);
                            }    
                            treechild.setChildren(null);
                        }
                        tree.setChildren(null);
                    }
                }
            }    
			for(TreeObject treeNode :listtree) {
				if(treeNode.getLevel() == 1) treeNode.setName( treeNode.getTreeDesc() + "."+ treeNode.getName());
			}
			model.addAttribute("listtree",listtree);
			return "/index";
//		}
//		return "/login";
	}
	
}
