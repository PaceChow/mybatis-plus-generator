package ${package.Mapper};

import ${package.Entity}.${entity};
import ${superMapperClassPackage};
import org.springframework.stereotype.Repository;

/**
 * <p>
 *   ${table.comment!} Mapper 接口
 * </p>
 * @copyright
 * @author  ${author}
 * @date    ${date}
 * @version V1.0
 */
@Repository
<#if kotlin>
interface ${table.mapperName} : ${superMapperClass}<$(entity)>
<#else>
public interface ${table.mapperName} extends ${superMapperClass}<${entity}> {



}
</#if>
