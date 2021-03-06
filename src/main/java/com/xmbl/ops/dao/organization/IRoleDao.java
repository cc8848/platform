package com.xmbl.ops.dao.organization;

import java.util.List;

import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.organization.Role;


public interface IRoleDao extends IEntityDao<Role> {
	
	public long searchCount(Integer status);
	
	public List<Role> searchList(Integer status);
	
	public Role getRoleBySign(String roleSign);
	
	public Role selectByRoleName(String roleName);
	
	public Role selectByDescription(String description);
	
	public long searchResourceById(Long id);
 
	public Role getRoleById(Long id);
	
}
