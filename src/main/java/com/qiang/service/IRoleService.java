package com.qiang.service;

import com.qiang.domain.Role;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author Mr.锵
 * date 2020-02-22
 */
public interface IRoleService {
    /**
     * 根据roleid查询角色名称
     * @param roleid
     * @return
     */
    @Select("select * from role where roleid=#{roleid}")
    List<Role> findByRid(String  roleid);
    /**
     * 查询所有角色
     * @return
     */
    @Select("select * from role")
    List<Role> findAll();
}