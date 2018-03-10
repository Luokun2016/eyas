package com.eyas.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

/*
 * 表达式验证
 * 
 * */
public class FormulaTest {
 
	private static int value=0;
	
	private static boolean exist=false;

	public static boolean isNumeric(String str){
    	for(int i=str.length();--i>=0;){
    		int chr=str.charAt(i);
    	    if(chr<48 || chr>57){
    	    	return false;
    	    }
    	}
    	return true;
    }
	
	private static boolean isMatch(String regex, String orginal){  
        if (orginal == null || orginal.trim().equals("")) {  
            return false;  
        }  
        Pattern pattern = Pattern.compile(regex);  
        Matcher isNum = pattern.matcher(orginal);  
        return isNum.matches();  
    }  
  
    public static boolean isPositiveInteger(String orginal) {  
        return isMatch("^\\+{0,1}[1-9]\\d*", orginal);  
    }  
  
    public static boolean isNegativeInteger(String orginal) {  
        return isMatch("^-[1-9]\\d*", orginal);  
    }  
  
    public static boolean isWholeNumber(String orginal) {  
        return isMatch("[+-]{0,1}0", orginal) || isPositiveInteger(orginal) || isNegativeInteger(orginal);  
    }  
      
    public static boolean isPositiveDecimal(String orginal){  
        return isMatch("\\+{0,1}[0]\\.[1-9]*|\\+{0,1}[1-9]\\d*\\.\\d*", orginal);  
    }  
      
    public static boolean isNegativeDecimal(String orginal){  
        return isMatch("^-[0]\\.[1-9]*|^-[1-9]\\d*\\.\\d*", orginal);  
    }  
      
    public static boolean isDecimal(String orginal){  
        return isMatch("[-+]{0,1}\\d+\\.\\d*|[-+]{0,1}\\d*\\.\\d+", orginal);  
    }  
      
    public static boolean isRealNumber(String orginal){  
        return isWholeNumber(orginal) || isDecimal(orginal);  
    } 
	public boolean checkdata(String str,List alls){
		
		String[] vars=str.split("[^\\w]+");

		
		int datalength = vars.length;
		if("".equals(vars[0])){
			for(int i = 1 ; i < datalength; i++ ){
				System.out.println(vars[i]);
				System.out.println(alls.contains(vars[i]));
				if(isRealNumber(vars[i])){
					exist=true;
				}else{
					exist = alls.contains(vars[i]);
					System.out.println(exist);
				}
				if(!exist){
					return false;
				}
			}
		}else{
			for(int i = 0 ; i < datalength; i++ ){
				System.out.println(vars[i]);
				System.out.println(alls.contains(vars[i]));
				if(isRealNumber(vars[i])){
					exist=true;
				}else{
					exist = alls.contains(vars[i]);
					System.out.println(exist);
				}
				
				if(!exist){
					return false;
				}
			}
		}
		return true;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean checkFormula(String str){
		
		//测试表达式
		//String str="v1+(grd_1-v1)/(v1-v2)+1";
		//String str="((grd_1-v1)/(v1-v2))+1";
		//String str="V1+((grd_1-v1)/(333)(v1-v2))+123";
		String[] vars=str.split("[^\\w]+");
		String[] vars1=str.split("[^\\W]+");
		int datalength = vars.length;
		int oplength = vars1.length;
		double[] varsnum = new double[datalength]; 
		for(int m = 0 ; m < datalength; m++){
			varsnum[m] = m*0.001;
		}
		for(int i = 0 ; i < vars.length; i++ ){
			System.out.println("varsnum begin:"+varsnum[i]);
		}
		System.out.println(datalength+"------"+oplength);
		
		List all = new ArrayList();
		if(datalength+oplength==1){
			if(datalength==1){
				return true;
			}
			if(oplength==1){
				return false;
			}
		}else{
			System.out.println("------分隔----");
			System.out.println(vars[0]);
			String datafirst = vars[0];
			System.out.println(vars1[0]);
			String opfirst = vars1[0];
			System.out.println("------分隔----");
			for(int i = 0 ; i < vars.length; i++ ){
				System.out.println(vars[i]);
				for(int k = i+1 ; k < vars.length; k++){
					if(vars[k].equals(vars[i])){
						varsnum[k] = varsnum[i];
					}
				}
			}
			for(int i = 0 ; i < vars.length; i++ ){
				System.out.println("varsnum end:"+varsnum[i]);
			}
			System.out.println("------分隔----");
			for(int j = 0 ; j < vars1.length; j++){
				System.out.println(vars1[j]);
				
			}
			
			if(datalength == oplength){
				for(int k = 0 ; k < oplength ; k++){
					if("".equals(datafirst)){
						
						Integer length = vars1[k].length();
						while(length-->=1){
								
							System.out.println(vars1[k].substring(0, 1));
							all.add(vars1[k].substring(0, 1));
							vars1[k] = vars1[k].substring(1);
								
						}
						
						if((k+1)!=datalength){
							if("".equals(vars[k+1])){
								//all.add("!");
							}else if(isRealNumber(vars[k+1])){
								all.add(vars[k+1]);
							}else{
								//all.add(vars[k+1]);
								all.add(varsnum[k+1]);
							}
						}
					}
					if("".equals(opfirst)){
						if("".equals(vars[k])){
							//all.add("!");
						}else if(isRealNumber(vars[k])){
							all.add(vars[k]);
						}else{
							//all.add(vars[k]);
							all.add(varsnum[k]);
						}
						
						if((k+1)!=oplength){
							Integer length = vars1[k+1].length();
							while(length-->=1){
								
								System.out.println(vars1[k+1].substring(0, 1));
								all.add(vars1[k+1].substring(0, 1));
								vars1[k+1] = vars1[k+1].substring(1);
								
							}
						}
					}
				}
			}
			if(datalength > oplength){
				for(int k = 0 ; k < oplength ; k++){
					//先存操作符
					Integer length = vars1[k].length();
					while(length-->=1){
						
						System.out.println(vars1[k].substring(0, 1));
						all.add(vars1[k].substring(0, 1));
						vars1[k] = vars1[k].substring(1);
						
					}
					if("".equals(datafirst)){
						if("".equals(vars[k+1])){
							//all.add("!");
						}else if(isRealNumber(vars[k+1])){
							all.add(vars[k+1]);
						}else{
							//all.add(vars[k]);
							all.add(varsnum[k+1]);
						}
					}
					
				}
			}
			if(datalength < oplength){
				for(int k = 0 ; k < datalength ; k++){
					//先存变量
					if("".equals(vars[k])){
						//all.add("!");
					}else if(isRealNumber(vars[k])){
						all.add(vars[k]);
					}else{
						//all.add(vars[k]);
						all.add(varsnum[k]);
					}
					
					if("".equals(opfirst)){
						if((k+1)!=oplength){
							Integer length = vars1[k+1].length();
							while(length-->=1){
								
								System.out.println(vars1[k+1].substring(0, 1));
								all.add(vars1[k+1].substring(0, 1));
								vars1[k+1] = vars1[k+1].substring(1);
								
							}
						}
						
					}
					
				}
			}
			
			System.out.println(all);
			
			String code = "";
			for(int l = 0 ; l < all.size(); l++){
				code += all.get(l);
			}
			
			System.out.println(code.toString());
			ScriptEngineManager manager = new ScriptEngineManager(); 
		    ScriptEngine engine = manager.getEngineByName("javascript");
		    
		    try{
		    	if(code==""){
		    		System.out.println(String.valueOf(engine.eval(code)));
			    	value=0;
		    	}else{
		    		System.out.println(engine.eval(code));
		    		if("Infinity".equals(String.valueOf(engine.eval(code)))
		    				||"-Infinity".equals(String.valueOf(engine.eval(code)))
		    				||"NaN".equals(String.valueOf(engine.eval(code)))
		    		){
		    			value=0;
		    			//System.out.println("hahaha");
		    		}else{
		    			value=1;
		    		}
		    	}
		    }catch(ScriptException ex){
		    	ex.printStackTrace();
		    	
		    	value=0;
		    }
			System.out.println(value);
		    if(value==0){
		    	System.out.println("Wrong");
		    	return false;
		    }else{
		    	System.out.println("Right");
		    	return true;
		    }
		}
		return false;
		
	}
	
	//测试用
	public static void main(String[] args) {
		String a = "1";
		//a = "a+b/c";
		a = "(v4-v4)/(grd_1-grd_1+1";
		FormulaTest f = new FormulaTest();
		f.checkFormula(a);
	}
}
