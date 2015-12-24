<?xml version="1.0" encoding="UTF-8"?>
<definitions targetNamespace="http://activate.f5.com/license/services/urn:com.f5.license.v5b.ActivationService" xmlns="http://schemas.xmlsoap.org/wsdl/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:impl="http://activate.f5.com/license/services/urn:com.f5.license.v5b.ActivationService-impl" xmlns:intf="http://activate.f5.com/license/services/urn:com.f5.license.v5b.ActivationService" xmlns:tns1="urn:com.f5.license.v5b" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><types><schema targetNamespace="urn:com.f5.license.v5b" xmlns="http://www.w3.org/2001/XMLSchema"><complexType name="LicenseTransaction"><sequence><element name="license" nillable="true" type="xsd:string"/><element name="eula" nillable="true" type="xsd:string"/><element name="state" nillable="true" type="tns1:TransactionState"/><element name="fault" nillable="true" type="tns1:LicensingFault"/></sequence></complexType><simpleType name="TransactionState"><restriction base="xsd:string"><enumeration value="LICENSE_RETURNED"/><enumeration value="EULA_REQUIRED"/><enumeration value="EMAIL_REQUIRED"/><enumeration value="CONTACT_INFO_REQUIRED"/><enumeration value="FAULT_RETURNED"/></restriction></simpleType><complexType name="LicensingFault"><sequence><element name="faultNumber" type="xsd:int"/><element name="faultText" nillable="true" type="xsd:string"/></sequence></complexType><element name="LicenseTransaction" nillable="true" type="tns1:LicenseTransaction"/></schema></types>
  <message name="pingResponse">
    <part name="return" type="xsd:string"/>
  </message>
  <message name="getLicenseRequest">
    <part name="dossier" type="xsd:string"/>
    <part name="eula" type="xsd:string"/>
    <part name="email" type="xsd:string"/>
    <part name="firstName" type="xsd:string"/>
    <part name="lastName" type="xsd:string"/>
    <part name="companyName" type="xsd:string"/>
    <part name="phone" type="xsd:string"/>
    <part name="jobTitle" type="xsd:string"/>
    <part name="address" type="xsd:string"/>
    <part name="city" type="xsd:string"/>
    <part name="stateProvince" type="xsd:string"/>
    <part name="postalCode" type="xsd:string"/>
    <part name="country" type="xsd:string"/>
  </message>
  <message name="pingRequest">
  </message>
  <message name="getLicenseResponse">
    <part name="return" type="tns1:LicenseTransaction"/>
  </message>
  <portType name="ActivationServiceProxy">
    <operation name="ping">
      <input message="intf:pingRequest"/>
      <output message="intf:pingResponse"/>
    </operation>
    <operation name="getLicense" parameterOrder="dossier eula email firstName lastName companyName phone jobTitle address city stateProvince postalCode country">
      <input message="intf:getLicenseRequest"/>
      <output message="intf:getLicenseResponse"/>
    </operation>
  </portType>
  <binding name="urn:com.f5.license.v5b.ActivationServiceSoapBinding" type="intf:ActivationServiceProxy">
    <wsdlsoap:binding style="rpc" transport="http://schemas.xmlsoap.org/soap/http"/>
    <operation name="ping">
      <wsdlsoap:operation soapAction=""/>
      <input>
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://activate.f5.com/license/services/urn:com.f5.license.v5b.ActivationService" use="encoded"/>
      </input>
      <output>
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://activate.f5.com/license/services/urn:com.f5.license.v5b.ActivationService" use="encoded"/>
      </output>
    </operation>
    <operation name="getLicense">
      <wsdlsoap:operation soapAction=""/>
      <input>
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://activate.f5.com/license/services/urn:com.f5.license.v5b.ActivationService" use="encoded"/>
      </input>
      <output>
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://activate.f5.com/license/services/urn:com.f5.license.v5b.ActivationService" use="encoded"/>
      </output>
    </operation>
  </binding>
  <service name="ActivationServiceProxyService">
    <port binding="intf:urn:com.f5.license.v5b.ActivationServiceSoapBinding" name="urn:com.f5.license.v5b.ActivationService">
      <wsdlsoap:address location="http://activate.f5.com/license/services/urn:com.f5.license.v5b.ActivationService"/>
    </port>
  </service>
</definitions>
