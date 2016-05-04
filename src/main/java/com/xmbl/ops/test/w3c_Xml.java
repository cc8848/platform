package com.xmbl.ops.test;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
 
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
 
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
 
public class w3c_Xml {
     
    static DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    static DocumentBuilder builder = null;
     
 public static void readXML() {
  try {
      builder = factory .newDocumentBuilder();   
      Document document = builder.parse(new File("E:\\testFiles\\test.xml"));
      Element rootElement = document.getDocumentElement();
 
      NodeList list = rootElement.getElementsByTagName("Header");
      Element element = (Element) list.item(0);
      System.out.println(element.getChildNodes().item(0).getNodeValue());
 
  } catch (Exception e) {
      System.out.println("exception:" + e.getMessage());
  }
 }
  
 public static void writeXML(Document document,String filename)
 {
     try {
         builder = factory .newDocumentBuilder();   
         //Document document = builder.parse(new File("E:\\testFiles\\test.xml"));
         document.normalize(); 
          
         /** 将document中的内容写入文件中 */
         TransformerFactory tFactory = TransformerFactory.newInstance();
         Transformer transformer = tFactory.newTransformer();
         transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
         transformer.setOutputProperty(OutputKeys.INDENT, "yes");
         //编码
         DOMSource source = new DOMSource(document);
         PrintWriter pw = new PrintWriter(new FileOutputStream(filename));
         StreamResult result = new StreamResult(pw);
         transformer.transform(source, result);
     } catch (Exception e) {
            e.printStackTrace();
        }
      
 }
  
 public static void updateXML()
 {
     try {
        builder = factory .newDocumentBuilder();
        Document document = builder.parse(new File("E:\\test.xml"));
        Node root = document.getDocumentElement();
        /**如果root有子元素*/
        if(root.hasChildNodes())
        {
            NodeList ftpnodes = root.getChildNodes();
            /**循环取得ftpnodes所有节点*/
            for(int i=0;i<ftpnodes.getLength();i++)
            {
                Node ftpList = ftpnodes.item(i);
//                System.out.println(ftpList.getTextContent());
            }
            for(int i=0;i<ftpnodes.getLength();i++)
            {
                Node ftpList = ftpnodes.item(i);
//                ftpList.setTextContent(ftpList.getTextContent()+" update");
            }
        }
        writeXML(document,"E:\\test2.xml");
         
     } catch (Exception e) {
        e.printStackTrace();
     }  
 }
  
  
 public static void main(String[] args)
 {
     //read
//     readXML();
     //write
     //writeXML(document,"E:\\testFiles\\test.xml");
     //update
     updateXML();
 }
}