/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ada.common;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

/**
 * @author Hi
 */
public class FileCommon {

    private static Logger logger = LogManager.getLogger(FileCommon.class);
    public static String PATH_DIR = ConfigProperties.getConfigProperties("uploadDir");
    public static String PATH_FILE_VIDEOCALL = ConfigProperties.getConfigProperties("PATH_UPLOAD_VIDEOCALL");
    public static String PATH_FILE_INDENTITY = ConfigProperties.getConfigProperties("PATH_UPLOAD_INDENTITY");
    public static String PATH_FILE_EKYC = ConfigProperties.getConfigProperties("PATH_UPLOAD_EYKC");
    public static String PATH_FILE_IMPORT_SIMSTOCK = ConfigProperties.getConfigProperties("PATH_UPLOAD_EXCEL_SIMSTOCK");
    public static String PATH_FILE_IMPORT_DOISOAT = ConfigProperties.getConfigProperties("PATH_UPLOAD_EXCEL_DOISOAT");
    public static String PATH_UPLOAD_EXCEL_SHOPCODE = ConfigProperties.getConfigProperties("PATH_UPLOAD_EXCEL_SHOPCODE");

    public static List<List<Map<String, String>>> readMapFromTextContent(String text, String listSeparator) {
        List<List<Map<String, String>>> results = new ArrayList<>();
        List<Map<String, String>> result = null;
        if (!isNullOrEmpty(text)) {
            String[] sheet = text.split("</sheet>");
            for (int s = 0; s < sheet.length; s++) {

                text = sheet[s];
                result = new ArrayList<>();

                String[] lines = text.split("/n");
                String[] headers = lines[0].split(listSeparator);

                for (int i = 1; i <= lines.length - 1; ++i) {
                    String[] values = lines[i].split(listSeparator);
                    Map<String, String> entries = new HashMap();
                    int flagNull = 0;

                    for (int j = 0; j < headers.length; ++j) {
                        String header = trim(headers[j]);
                        if (j >= values.length) {
                            entries.put(header, null);
                            flagNull++;
                            continue;
                        }
                        String value = trim(values[j]);
                        if (!isNullOrEmpty(value)) {
                            if (entries.containsKey(header)) {
                                throw new RuntimeException(String.format("Csv data with header = %s in line %s is already existed", header, i));
                            }
                            entries.put(header, value);
                            System.out.println(String.format("Row: %s - Header: %s - value: %s", i, header, value));
                        } else {
                            System.out.println(String.format("Header = %s in line %s is not enought", header, i));
                            flagNull++;
                            entries.put(header, null);
                        }
                    }

                    if (entries.size() > 0) {
                        if (flagNull < headers.length) {
                            result.add(entries);
                        }
                    }
                }
                results.add(result);
            }
        }
        return results;
    }

    public static String readFileContentExcel(String path, int indexStart) {
        String text = "";
        // Creating a Workbook from an Excel file (.xls or .xlsx)
        try {
            int flagSkip = 0;
            FileInputStream excelFile = new FileInputStream(new File(path));

//            Workbook workbook = WorkbookFactory.create(new File(path));
            try (Workbook workbook = new XSSFWorkbook(excelFile)) {

                //            Workbook workbook = WorkbookFactory.create(new File(path));
                System.out.println(String.format("Have %s sheet on this workbook", workbook.getNumberOfSheets()));
                Sheet sheet = null;
                for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
                    if (workbook.isSheetHidden(i)) {
                        System.out.println("Hidden sheet is " + i);
                        continue;
                    }
                    flagSkip += 1;
                    System.out.println("Show sheet is " + i);

                    if (flagSkip > indexStart) {
                        sheet = workbook.getSheetAt(i);

                        // Create a DataFormatter to format and get each cell's value as String
                        DataFormatter dataFormatter = new DataFormatter();

                        // 1. You can obtain a rowIterator and columnIterator and iterate over them
                        Iterator<Row> rowIterator = sheet.rowIterator();
                        while (rowIterator.hasNext()) {
                            Row row = rowIterator.next();

                            // Now let's iterate over the columns of the current row
                            Iterator<Cell> cellIterator = row.cellIterator();

                            int flagCell = 0;
                            while (cellIterator.hasNext()) {
                                Cell cell = cellIterator.next();
                                String cellValue = dataFormatter.formatCellValue(cell);
                                if (flagCell == 0) {
                                    text += cellValue;
                                    flagCell++;
                                } else {
                                    text = text + ";" + cellValue;
                                    flagCell++;
                                }

                            }
                            text += "/n";
                        }
                        text += "</sheet>";
                    }
                }
                // Closing the workbook
                workbook.close();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                excelFile.close();
            }
            return text;
        } catch (IOException e) {
            e.printStackTrace();
            return text;
        }
    }

    public static String readFileContentExcel(File file) {
        String text = "";
        // Creating a Workbook from an Excel file (.xls or .xlsx)
        try {
            int flagSkip = 0;
            FileInputStream excelFile = new FileInputStream(file);
//            Workbook workbook = WorkbookFactory.create(new File(path));
            try (Workbook workbook = new XSSFWorkbook(excelFile)) {
                //            Workbook workbook = WorkbookFactory.create(new File(path));
                System.out.println(String.format("Have %s sheet on this workbook", workbook.getNumberOfSheets()));
                Sheet sheet = null;
                for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
                    if (workbook.isSheetHidden(i)) {
                        System.out.println("Hidden sheet is " + i);
                        continue;
                    }
                    flagSkip += 1;
                    System.out.println("Show sheet is " + i);

                    if (flagSkip >= 1) {
                        sheet = workbook.getSheetAt(i);

                        // Create a DataFormatter to format and get each cell's value as String
                        DataFormatter dataFormatter = new DataFormatter();

                        // 1. You can obtain a rowIterator and columnIterator and iterate over them
                        Iterator<Row> rowIterator = sheet.rowIterator();
                        while (rowIterator.hasNext()) {
                            Row row = rowIterator.next();

                            // Now let's iterate over the columns of the current row
                            Iterator<Cell> cellIterator = row.cellIterator();

                            int flagCell = 0;
                            while (cellIterator.hasNext()) {
                                Cell cell = cellIterator.next();
                                String cellValue = dataFormatter.formatCellValue(cell);
                                if (flagCell == 0) {
                                    text += cellValue;
                                    flagCell++;
                                } else {
                                    text = text + ";" + cellValue;
                                    flagCell++;
                                }
                            }
                            text += "/n";
                        }
                        text += "</sheet>";
                    }
                }
                // Closing the workbook
            }
            return text;
        } catch (IOException e) {
            e.printStackTrace();
            return text;
        }

    }

    public static String write(MultipartFile file, String dir) {
        Path filepath = Paths.get(dir, String.format("%s_%s", file.getOriginalFilename(), new Date().getTime()));

        try {
            OutputStream os = Files.newOutputStream(filepath);
            os.write(file.getBytes());
        } catch (IOException ioException) {
            ioException.printStackTrace();
            return null;
        }
        return filepath.toString();
    }

    public static String base64ToImage(String image64, String pathFile, String filename) {
        String pathEnd = pathFile + filename;
        File file = new File(pathEnd);
        File dir = new File(pathFile);

        try {
            if (!file.exists()) {
                dir.mkdir();
            }
            byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(image64);
            if (imageBytes.length > 5242880) {
                return null;
            }
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            fileOutputStream.write(imageBytes);
            String[] pathEnds = pathEnd.split("/upload");
            if (pathEnds.length == 2) {
                pathEnd = "/upload" + pathEnds[1];
            }
            return pathEnd;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Boolean uploadImageBase64(String nameImage, String pathFile, String base64Image) {

        Path path = Paths.get(pathFile);
        logger.info("UPLOAD_IMAGE_BASE_64: path is: " + pathFile);
        logger.info("UPLOAD_IMAGE_BASE_64: image64 is: " + base64Image);
        try {
            Files.createDirectories(path);
            OutputStream stream = new FileOutputStream(pathFile + nameImage);
            byte[] data = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
            logger.info("UPLOAD_IMAGE_BASE_64: data length: " + data.length);
//			if (data.length > 5242880) {
//				return false;
//			}
            stream.write(data);
            stream.close();
        } catch (Exception e) {
            logger.warn("UPLOAD_IMAGE_BASE_64: Exception " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        logger.info("UPLOAD_IMAGE_BASE_64: UPLOAD SUCCESS");
        return true;
    }

    //    ------------------------------Helper------------------------------------------
    public static String trim(String value) {
        return value != null ? value.trim() : null;
    }

    public static boolean isNullOrEmpty(String value) {
        return value == null ? true : value.trim().isEmpty();
    }

}
