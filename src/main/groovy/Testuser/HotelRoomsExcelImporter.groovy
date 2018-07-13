package Testuser

import com.sun.org.apache.xalan.internal.xsltc.compiler.util.StringType
import org.grails.plugins.excelimport.AbstractExcelImporter
import org.grails.plugins.excelimport.DefaultImportCellCollector
import org.grails.plugins.excelimport.ExcelImportService
import org.springframework.beans.factory.annotation.Autowired

class HotelRoomsExcelImporter extends AbstractExcelImporter{


    static cellReporter = new DefaultImportCellCollector()

    @Autowired
    ExcelImportService excelImportService

    HotelRoomsExcelImporter(file){
        super(file)
        excelImportService = ExcelImportService.getService()
    }

    static Map configuratiomMap = [
            code: ([expectedType: StringType, defaultValue: ""]),
            id: ([expectedType: StringType, defaultValue: ""])
    ]

    static Map CONFIG_PAYMENT_COLUMN_MAP = [
            sheet:'Sheet1',
            startRow: 1,
            columnMap:  [
                    'A':'roomNo',
                    'B':'availability',
            ]
    ]

    List<Map> list() {
        excelImportService.columns(
                workbook,
                CONFIG_PAYMENT_COLUMN_MAP,
                cellReporter,
                configuratiomMap
        )
    }

}
