package com;

import com.baomidou.mybatisplus.core.exceptions.MybatisPlusException;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.converts.MySqlTypeConvert;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.config.rules.IColumnType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.google.common.collect.Maps;

import java.util.*;

/**
 * @author Pace
 * @date 2021/4/9
 */
public class Generator {

    private static final String projectPath = System.getProperty("user.dir") ;

    private static final String basePackageName = "com.sxd.newportal.system";

    private static final String packageModuleName = "sys";

    private static final String mysqlAddress = "127.0.0.1:3306";

    private static final String mysqlDbName = "zpstest";

    private static final String mysqlUsername = "root";

    private static final String mysqlPassword = "root";

    public static void main(String[] args) {

        //输入表名称，多个表按照分号隔开，例如："table1;table2;table3;..."
        String tablesNames = "sys_user";
        String authorName = "Pace";
        exec(tablesNames, authorName);

    }

    private static void exec(String tablesNames, String authorName) {

        // 全局配置
        GlobalConfig gc = new GlobalConfig();
        gc.setOutputDir(projectPath + "/src/main/java")
            .setAuthor(authorName)
            .setOpen(false)
            .setSwagger2(true) //实体属性 Swagger2 注解
            .setFileOverride(true) // 是否覆盖文件
            .setBaseResultMap(true) // xml resultmap
            .setBaseColumnList(true); // xml columlist

        // 数据源配置
        DataSourceConfig dsc = new DataSourceConfig();
        String url = String.format("jdbc:mysql://%s/%s?characterEncoding=utf8&useSSL=false&serverTimezone=UTC", mysqlAddress, mysqlDbName);
        dsc.setUrl(url);
        dsc.setDriverName("com.mysql.cj.jdbc.Driver");
        dsc.setUsername(mysqlUsername);
        dsc.setPassword(mysqlPassword);
        dsc.setTypeConvert(new MySqlTypeConvert() {
            // 自定义数据库表字段类型转换【可选】
            @Override
            public IColumnType processTypeConvert(GlobalConfig globalConfig, String fieldType) {
                if ( fieldType.toLowerCase().contains( "datetime" ) ) {
                    return DbColumnType.DATE;
                }
                return super.processTypeConvert(globalConfig, fieldType);
            }
        });

        // 包配置
        PackageConfig pc = new PackageConfig();
        pc.setParent(basePackageName);
        pc.setController("controller." + packageModuleName);
        pc.setService("service." + packageModuleName);
        pc.setServiceImpl("service." + packageModuleName +".impl");
        pc.setEntity("repository." + packageModuleName +".entity");
        pc.setMapper("repository." + packageModuleName +".mapper");
        pc.setXml("mapper." + packageModuleName);

        // 自定义配置 这里可以对ftl模板的传参设置，通过map把参数传入模板内进行替换
        InjectionConfig cfg = new InjectionConfig() {
            @Override
            public void initMap() {
                List<TableInfo> tableInfoList = this.getConfig().getTableInfoList();
                for (TableInfo tableInfo : tableInfoList) {
                    tableInfo.setComment(tableInfo.getComment().replace("表",""));
                }
                Map<String, Object> map = Maps.newHashMap();
                map.put("base_package_name", basePackageName);
                map.put("package_module_name", packageModuleName);
                this.setMap(map);
            }
        };

//        // 如果模板引擎是 freemarker
//        String templatePath = "/templates/mapper.xml.ftl";
//        // 自定义输出配置
//        List<FileOutConfig> focList = new ArrayList<>();
//        // 自定义配置会被优先输出
//        focList.add(new FileOutConfig(templatePath) {
//            @Override
//            public String outputFile(TableInfo tableInfo) {
//                // 自定义输出文件名 ， 如果你 Entity 设置了前后缀、此处注意 xml 的名称会跟着发生变化！！
//                return projectPath + "/src/main/resources/mapper/" + basePackageName
//                        + "/" + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
//            }
//        });
//        cfg.setFileOutConfigList(focList);
//        mpg.setCfg(cfg);


        // 策略配置
        StrategyConfig strategy = new StrategyConfig();
        strategy.setInclude(tablesNames.split(";"));
        strategy.setNaming(NamingStrategy.underline_to_camel);
        strategy.setColumnNaming(NamingStrategy.underline_to_camel);
        strategy.setEntityLombokModel(true);
        strategy.setRestControllerStyle(true);
        strategy.setEntityBooleanColumnRemoveIsPrefix(true);
        strategy.setControllerMappingHyphenStyle(true);


        // 代码生成器
        AutoGenerator mpg = new AutoGenerator();
        mpg.setGlobalConfig(gc);
        mpg.setDataSource(dsc);
        mpg.setStrategy(strategy);
        mpg.setTemplate(new TemplateConfig());  // 配置模板
        mpg.setTemplateEngine(new FreemarkerTemplateEngine());
        mpg.setPackageInfo(pc);
        mpg.setCfg(cfg);
        mpg.execute();
    }

    //    /**
//     * <p>
//     * 读取控制台内容
//     * </p>
//     */
//    public static String scanner(String tip) {
//        Scanner scanner = new Scanner(System.in);
//        StringBuilder help = new StringBuilder();
//        help.append("请输入" + tip + "：");
//        System.out.println(help.toString());
//        if (scanner.hasNext()) {
//            String ipt = scanner.next();
//            if (StringUtils.isNotEmpty(ipt)) {
//                return ipt;
//            }
//        }
//        throw new MybatisPlusException("请输入正确的" + tip + "！");
//    }
}
