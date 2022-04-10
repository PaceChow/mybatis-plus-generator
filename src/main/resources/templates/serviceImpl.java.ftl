package ${package.ServiceImpl};

import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${superServiceImplClassPackage};
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

/**
 * <p>
 * ${table.comment!} 服务实现类
 * </p>
 * @copyright
 * @author  ${author}
 * @date    ${date}
 * @version V1.0
 * @description
*/
@Service
<#if kotlin>
open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

}
<#else>
public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}> implements ${table.serviceName} {

    @Override
    public  IPage<${entity}> find${entity}ListByPage(Integer page, Integer pageCount){
        IPage<${entity}> wherePage = new Page<>(page, pageCount);
        ${entity} where = new ${entity}();

        return baseMapper.selectPage(wherePage, Wrappers.query(where));
    }

    @Override
    public int add${entity}(${entity} ${entity?uncap_first}){
        return baseMapper.insert(${entity?uncap_first});
    }

    @Override
    public int delete${entity}ById(Integer id){
        return baseMapper.deleteById(id);
    }

    @Override
    public int update${entity}ById(${entity} ${entity?uncap_first}){
        return baseMapper.updateById(${entity?uncap_first});
    }

    @Override
    public ${entity} find${entity}ById(Integer id){
        return baseMapper.selectById(id);
    }
}
</#if>
