import RichTextComponent from "./components/RichText/Rich_text.component";
import FormTest from "./features/test_form/Form_test.component";

const App = () => {
  return (
    <div>
      <FormTest />
      <div className="my-6">Rich Text</div>
      <div className="px-6">
        <RichTextComponent />
      </div>
    </div>
  );
};

export default App;
