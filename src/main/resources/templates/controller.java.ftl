package ${package.Controller};

import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import ${package.Service}.${table.serviceName};
import ${package.Entity}.${entity};
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import javax.validation.constraints.NotNull;
<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

/**
 * <p>
 * ${table.comment!} 前端控制器
 * </p>
 * @copyright
 * @author  ${author}
 * @date    ${date}
 * @version V1.0
 * @description
 */
<#if restControllerStyle>
@Api(tags = {"${table.comment!}接口"})
@RestController
<#else>
@Controller
</#if>
@RequestMapping("api/${cfg.package_module_name}/${table.entityPath}")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??>:${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>public class ${table.controllerName} extends ${superControllerClass}{
<#else>public class ${table.controllerName} {
</#if>

    private Logger log = LoggerFactory.getLogger(getClass());

    @Resource
    private ${table.serviceName} ${(table.serviceName?substring(1))?uncap_first};


    @ApiOperation(value = "新增${table.comment!}")
    @PostMapping()
    public BaseResponse<String> add(@RequestBody @ApiParam(value = "新增请求入参", required = true)
                                    @Validated ${entity} ${entity?uncap_first}){
        ${(table.serviceName?substring(1))?uncap_first}.add${entity}(${entity?uncap_first});
        return BaseResponse.ok();
    }

    @ApiOperation(value = "删除${table.comment!}")
    @DeleteMapping("{id}")
    public BaseResponse<String> delete(@PathVariable("id") Integer id){
        ${(table.serviceName?substring(1))?uncap_first}.delete${entity}ById(id);
        return BaseResponse.ok();
    }

    @ApiOperation(value = "更新${table.comment!}")
    @PutMapping()
    public BaseResponse<String> update(@RequestBody @ApiParam(value = "更新请求入参", required = true)
                                       @Validated ${entity} ${entity?uncap_first}){
        ${(table.serviceName?substring(1))?uncap_first}.update${entity}ById(${entity?uncap_first});
        return BaseResponse.ok();
    }

    @ApiOperation(value = "查询${table.comment!}分页数据")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "page", value = "页码"),
        @ApiImplicitParam(name = "pageCount", value = "每页条数")
    })
    @GetMapping()
    public BaseResponse<IPage<${entity}>> findListByPage(@RequestParam @NotNull Integer page,
                                   @RequestParam @NotNull Integer pageCount){
        return BaseResponse.ok(${(table.serviceName?substring(1))?uncap_first}.find${entity}ListByPage(page, pageCount));
    }

    @ApiOperation(value = "id查询${table.comment!}")
    @GetMapping("{id}")
    public BaseResponse<${entity}> findById(@PathVariable @NotNull Integer id){
        return BaseResponse.ok(${(table.serviceName?substring(1))?uncap_first}.find${entity}ById(id));
    }

}
</#if>