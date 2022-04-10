package ${package.Service};

import ${package.Entity}.${entity};
import ${superServiceClassPackage};
import com.baomidou.mybatisplus.core.metadata.IPage;

/**
 * <p>
 * ${table.comment!} 服务类
 * </p>
 * @copyright
 * @author  ${author}
 * @date    ${date}
 * @version V1.0
 * @description
*/
<#if kotlin>
interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
public interface ${table.serviceName} extends ${superServiceClass}<${entity}> {

    /**
     * 查询${table.comment!}分页数据
     *
     * @param page      页码
     * @param pageCount 每页条数
     * @return IPage<${entity}>
     */
    IPage<${entity}> find${entity}ListByPage(Integer page, Integer pageCount);

    /**
     * 添加${table.comment!}
     *
     * @param ${entity?uncap_first} ${table.comment!}
     * @return int
     */
    int add${entity}(${entity} ${entity?uncap_first});

    /**
     * 删除${table.comment!}
     *
     * @param id 主键
     * @return int
     */
    int delete${entity}ById(Integer id);

    /**
     * 修改${table.comment!}
     *
     * @param ${entity?uncap_first} ${table.comment!}
     * @return int
     */
    int update${entity}ById(${entity} ${entity?uncap_first});

    /**
     * id查询数据
     *
     * @param id id
     * @return ${entity}
     */
    ${entity} find${entity}ById(Integer id);
}
</#if>
