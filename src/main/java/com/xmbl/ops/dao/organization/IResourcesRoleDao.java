package com.xmbl.ops.dao.organization;

import java.util.List;




import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.organization.ResourcesRole;

public interface IResourcesRoleDao extends IEntityDao<ResourcesRole>   {

	List<ResourcesRole> getAllList(String role);

    Integer hasAuthentic(Integer role, Integer resourceId);
    
    Integer deleteResourceRole(Integer rescId);

}
